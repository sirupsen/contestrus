require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = users(:sirup)
    @task = tasks(:hello_world)
  end

  test "passed? with a user should return true with a succesful submission" do
    Submission.create(task: @task, user: @user, source: "puts 'Hello World'")
    work_off_jobs

    assert @task.passed?(@user)
  end

  test "passed? with a user should return false with no succesful submission" do
    Submission.create(task: @task, user: @user, source: "puts 'Hello'")
    work_off_jobs

    refute @task.passed?(@user)
  end
end
