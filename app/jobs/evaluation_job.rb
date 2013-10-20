require 'rubygems'
require 'rubygems/package'

require 'pusher'
Pusher.url = "http://92dab36b76c99a3d4cdb:651364431d5cea642023@api.pusherapp.com/apps/57268"
Pusher.logger = Rails.logger

require 'docker'

require 'fileutils'

class EvaluationJob
  SANDBOX_DIR = '/sandbox'
  SEGFAULT_STATUS = 139

  def initialize(submission_id)
    @submission_id = submission_id
  end

  def perform
    @temporary_dir = mktemp_dir

    File.open(File.join(@temporary_dir, "file.#{language.extension}"), 'w') do |f|
      f.write submission.source
    end

    if prepare_image
      begin
        @result = task.test_cases.map {|test_case| evaluate(test_case)}
        passed = @result.all? {|r| r[:status] == "Correct"}

        submission.update_attributes(
          status: if passed then "Passed" else "Failed" end,
          body: @result,
          passed: passed
        )
      ensure
        @prepared_image.remove if @prepared_image
      end
    else
      submission.update_attributes(
        status: "Build failed",
        passed: false,
        body: @build_body
      )
    end

    if config = APP_CONFIG['pusher']
      Thread.new(submission.user.username) do |username|
        sleep config['delay'].seconds
        Pusher[config['prefix'] + username].trigger('submission_judged', {})
      end
    end
  ensure
    FileUtils.rm_rf @temporary_dir
  end

  private

  def prepare_image
    c = create_container(language.image, "#{language.build} 1> /stdout 2> /stderr")
    c.start!(start_options)
    unless c.wait(30)['StatusCode'].zero?
      files = retrieve_stderr_stdout(c)
      @build_body = files['stdout'] + files['stderr']
      return false
    end
    @prepared_image = c.commit
  ensure
    c.delete if c
  end

  def evaluate(test_case)
    File.open(File.join(@temporary_dir, 'stdin'), 'w') do |f|
      f.write test_case.input
    end

    c = create_container(@prepared_image.id, "#{language.run} 1> /stdout 2> /stderr < #{SANDBOX_DIR}/stdin")
    t = Time.now
    c.start!(start_options)
    status_code = c.wait(task.restrictions["time"] || 2)['StatusCode']
    if status_code == SEGFAULT_STATUS
      {
        status: "Segmentation fault",
        duration: Time.now - t
      }
    else
      files = retrieve_stderr_stdout(c)

      {
        output: files['stdout'] + files['stderr'],
        status: if test_case.output.strip == files['stdout'].strip
          "Correct"
        else
          "Wrong"
        end,
        duration: Time.now - t
      }
    end
  rescue Docker::Error::TimeoutError
    {status: "Time limit exceeded", duration: Time.now - t}
  rescue => e
    {status: "Error"}
  ensure
    c.kill
    c.delete
  end

  def start_options
    {'Binds' => ["#{@temporary_dir}:#{SANDBOX_DIR}:r"]}
  end

  def retrieve_stderr_stdout(container)
    files = {}
    %w(/stderr /stdout).each do |name|
      data = StringIO.new
      container.copy(name) do |block|
        data << block
      end
      data.rewind
      Gem::Package::TarReader.new(data) do |tar|
       tar.each do |tarfile|
         files[tarfile.full_name] = tarfile.read || ""
       end
      end
    end
    files
  end

  def create_container(image, command)
    Docker::Container.create(
      'Image' => image,
      'Memory' => task.restrictions["memory"] || 128*1024*1024,
      'MemorySwap' => -1,
      'Cmd' => ["/bin/bash", "-c", command],
      'Volumes' => {SANDBOX_DIR => {}},
      'NetworkDisabled' => true
    )
  end

  def language
    submission.language
  end

  def task
    submission.task
  end

  def mktemp_dir
    `mktemp --directory`.strip
  end

  def submission
    @submission ||= Submission.find(@submission_id)
  end
end
