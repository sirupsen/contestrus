require 'tempfile'

class EvaluationJob
  def initialize(submission_id)
    @submission_id = submission_id
  end

  def perform
    program = Tempfile.new('submission')
    program.write(submission.source)
    program.flush

    results = submission.task.test_cases.map { |test_case|
      input = Tempfile.new('test_case_input')
      input.write(test_case.input)
      input.flush

      user_output = `ruby #{program.path} < #{input.path} 2>&1`

      {
        test_case_id: test_case.id,
        actual: user_output.strip,
        expected: test_case.output,
        passed: user_output.strip == test_case.output.strip
      }
    }

    submission.evaluations.create(
      passed: results.all? { |e| e[:passed] },
      body: results
    )

    program.unlink
  end

  private
  def submission
    Submission.find(@submission_id)
  end
end
