require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  setup do
    @user = users(:sirup)
    @task = tasks(:hello_world)
  end

  test "enqueue evaluation job after create" do
    assert_difference "BackgroundJob.size", +1 do
      submission = Submission.create(user: @user, task: @task, source: "puts 'hello world'", lang: "ruby")
    end
  end

  test "passed? should return true if all evaluations passed" do
    submission = Submission.create(user: @user, task: @task, source: "puts 'Hello World'", lang: "ruby")
    work_off_jobs

    assert submission.passed?
  end

  test "passed? should return false if an evaluations did not pass" do
    submission = Submission.create(user: @user, task: @task, source: "puts 'hello panda'", lang: "ruby")
    work_off_jobs

    refute submission.passed?
  end

  test "language should autodetect language" do
    submission = Submission.create(user: @user, task: @task, source: "puts 'hello world'", path: "original.rb")
    assert_equal "ruby", submission.language
  end
end
