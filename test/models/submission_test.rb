require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  setup do
    @user = users(:sirup)
    @task = tasks(:hello_world)
  end

  test "creates valid submission" do
    assert Submission.create(valid_submission_attributes)
  end

  test "validates presence of source" do
    refute Submission.new(valid_submission_attributes.merge(source: nil)).valid?
  end

  test "validates presence of path" do
    refute Submission.new(valid_submission_attributes.merge(path: nil)).valid?
  end

  test "validates unknown file extension" do
    refute Submission.new(valid_submission_attributes.merge(path: "test.txt")).valid?
  end

  test "set language on creation" do
    submission = Submission.create(valid_submission_attributes)
    assert_equal "ruby", submission.lang
  end

  test "enqueue evaluation job after create" do
    assert_difference "BackgroundJob.size", +1 do
      Submission.create(valid_submission_attributes)
    end
  end

  test "passed? should return true if all evaluations passed" do
    submission = Submission.create(valid_submission_attributes)
    work_off_jobs

    assert submission.passed?
  end

  test "passed? should return false if an evaluations did not pass" do
    submission = Submission.create(valid_submission_attributes.merge(
      source: "puts 'Hello'"
    ))

    work_off_jobs

    refute submission.passed?
  end

  test "passed? should return false when there are no evaluations" do
    submission = Submission.create(valid_submission_attributes)
    refute submission.passed?, "Submission with no evaluations should fail"
  end

  private
  def valid_submission_attributes
    {
      user: @user,
      task: @task,
      source: "puts 'Hello World'",
      path: "test.rb"
    }
  end
end
