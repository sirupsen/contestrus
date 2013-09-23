require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  setup do
    @user = users(:sirup)
    @task = tasks(:mega_inversions)
  end

  teardown do
    BackgroundJob.destroy
  end

  test "enqueue evaluation job after create" do
    assert_difference "BackgroundJob.size", +1 do
      submission = Submission.create(user: @user, task: @task, source: "puts 'hello world'", lang: "ruby-mri-2.0.0p247")
    end
  end
end
