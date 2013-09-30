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
    result[:output]   = output.strip.split("\n").map { |line| line.strip }.join("\n")

    unless result[:output] == test.output
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
      Timeout.timeout(task.restrictions[:time].to_f) do
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
  def submission
    Submission.find(@submission_id)
  end

  def evaluator
    @evaluator ||= Evaluator::Languages[submission.language].new(submission.source)
  end

  def task
    submission.task
  end
end
