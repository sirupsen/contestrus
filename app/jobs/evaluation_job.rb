require 'tempfile'
require 'evaluator'

class EvaluationJob
  def initialize(submission_id)
    @submission_id = submission_id
  end

  def perform
    results = []

    unless evaluator.compile === true
      results << {
        status: "compilation failure",
        output: evaluator.compile
      }
    else
      results = task.test_cases.map { |test| evaluate(test) }
    end

    submission.evaluations.create(
      passed: results.all? { |e| e[:status] == "passed" },
      body: results
    )

  ensure
    evaluator.clean
  end

  def evaluate(test)
    result = {id: test.id}

    past = Time.now
    output = run_test(test)

    if output == :timeout
      result[:status] = "timeout"
      return result
    end

    result[:duration] = Time.now - past
    result[:output]   = strip_all_lines(output)

    unless strip_all_lines(result[:output]) == strip_all_lines(test.output)
      result[:status] = "wrong answer"
      return result
    end

    result[:status] = "passed"
    result
  end

  def run_test(test)
    output = Tempfile.new("output")

    pid = Process.spawn("#{evaluator.command(stdin: test.input)} > #{output.path}", :pgroup => true)
    begin
      Timeout.timeout(task.restrictions[:time] || 2.0) do
        Process.wait(pid)
      end
    rescue Timeout::Error
      Process.kill("KILL", -Process.getpgid(pid))
      return :timeout
    end

    buffer = output.read
    output.unlink

    buffer
  end

  private
  def evaluator
    Evaluator::Languages[submission.lang].new(submission.source)
  end

  def task
    submission.task
  end

  def submission
    @submission ||= Submission.find(@submission_id)
  end

  def strip_all_lines(s)
    s.strip.split("\n").map { |line| line.strip }.join("\n")
  end
end
