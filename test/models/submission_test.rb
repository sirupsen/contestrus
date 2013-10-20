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

  test "validates unknown language" do
    refute Submission.new(valid_submission_attributes.merge(path: "test.txt")).valid?
  end

  test "validates within contest is within open time" do
    competition = competitions(:past)
    task = competition.tasks.first
    refute Submission.new(valid_submission_attributes.merge(task: task)).valid?, 
      "Submission for past competition should give a validation error."
  end

  test "set language on creation" do
    submission = Submission.create(valid_submission_attributes)
    assert_equal languages(:ruby), submission.language
  end

  test "passed? should return true if evaluation passed" do
    submission = Submission.create(valid_submission_attributes)
    assert submission.reload.passed?, "Submission should pass when code is correct."
  end

  test "passed? should return false if evaluation did not pass" do
    submission = Submission.create(valid_submission_attributes.merge(
      source: "puts 'Hello'"
    ))
    refute submission.passed?
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
