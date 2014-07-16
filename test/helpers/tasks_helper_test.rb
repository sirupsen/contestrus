require 'test_helper'

class TasksHelperTest < ActionView::TestCase
  test "#evaluation_time returns the approximate evaluation time of a task" do
    task = tasks(:sum)
    assert_equal "less than a minute", evaluation_time(task)
  end
end
