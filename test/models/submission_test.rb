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

  test "set language on creation" do
    submission = Submission.create(valid_submission_attributes)
    assert_equal "ruby", submission.language
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

  test "competition_id is set for an ongoing competition" do
    @task = tasks(:ongoing_hello_world)

    submission = Submission.create(valid_submission_attributes)
    assert_equal competitions(:ongoing), submission.competition
  end

  test "competition_id is not set for a past competition" do
    @task = tasks(:past_hello_world)

    submission = Submission.create(valid_submission_attributes)
    refute submission.competition
  end

  test "competition_id is set for an open competition" do
    @task = tasks(:hello_world)

    submission = Submission.create(valid_submission_attributes)
    assert_equal competitions(:open), submission.competition
  end

  test "passed_task.during_competition returns true when solved task during competition" do
    @task = tasks(:ongoing_hello_world)

    submission = Submission.create(valid_submission_attributes).reload
    assert @user.submissions.passed.for_task(@task).during_competition.any?
  end

  test "passed_task.during_competition returns false when solved task after competition" do
    @task = tasks(:past_hello_world)

    submission = Submission.create(valid_submission_attributes).reload
    refute @user.submissions.passed.for_task(@task).during_competition.any?
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
