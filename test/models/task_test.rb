require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = users(:sirup)
    @task = tasks(:hello_world)
  end

  test "passed? with a user should return true with a succesful submission" do
    Submission.create!(task: @task, user: @user, source: "puts 'Hello World'", path: "whatever.rb")
    assert @task.passed?(@user)
  end

  test "passed? with a user should return false with no succesful submission" do
    Submission.create!(task: @task, user: @user, source: "puts 'Hello'", path: "whatever.rb")
    refute @task.passed?(@user)
  end

  test "times_solved should return the number of times a task has been solved" do
    Submission.create!(task: @task, user: users(:sirup), source: "puts 'Hello World'", path: "whatever.rb")
    Submission.create!(task: @task, user: users(:bob), source: "puts 'Hello World'", path: "whatever.rb")

    assert_equal 2, @task.reload.times_solved
  end

  test "times_solved should only count successful submissions once" do
    Submission.create!(task: @task, user: users(:sirup), source: "puts 'Hello World'", path: "whatever.rb")
    Submission.create!(task: @task, user: users(:sirup), source: "puts 'Hello World'", path: "whatever.rb")

    assert_equal 1, @task.reload.times_solved
  end

  test "times_solved should not count incorrect submissions" do
    Submission.create!(task: @task, user: users(:sirup), source: "puts 'wrong'", path: "whatever.rb")

    assert_equal 0, @task.reload.times_solved
  end

  test "#solved returns tasks that have been solved" do
    Submission.create!(task: @task, user: users(:sirup), source: "puts 'wrong'", path: "whatever.rb")
    assert_equal [@task], users(:sirup).tasks.solved
  end

  test "#solved returns tasks only that one user has solved" do
    Submission.create!(task: @task, user: users(:sirup), source: "puts 'wrong'", path: "whatever.rb")
    assert_equal [], users(:bob).tasks.solved
  end
end
