require 'test_helper'

class EvaluationJobTest < ActiveSupport::TestCase
  setup do
    @submission = Submission.create(
      task: tasks(:hello_world),
      user: users(:sirup),
      source: "puts 'Hello World'",
      lang: "ruby"
    )
  end

  test "create new evaluation" do
    assert_difference "Evaluation.count", +1 do
      work_off_jobs
    end
  end

  test "correct code passes hello world task" do
    work_off_jobs

    evaluation = @submission.evaluations.last
    assert evaluation.passed?, "Evaluation must passed"
  end

  test "incorrect code passes hello world task" do
    @submission.update_attribute :source, "puts 'omg'"
    @submission.save!

    BackgroundJob << EvaluationJob.new(@submission.id)
    work_off_jobs # before_create hook
    work_off_jobs # new one

    evaluation = @submission.evaluations.last
    refute evaluation.passed?, "Evaluation must not pass"
  end

  test "set body on evaluation" do
    work_off_jobs

    assert_equal([{
      test_case_id: @submission.task.test_cases.last.id,
      actual: "Hello World",
      expected: "Hello World",
      passed: true
    }], @submission.evaluations.last.body)
  end
end
