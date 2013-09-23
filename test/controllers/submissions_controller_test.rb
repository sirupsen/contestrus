require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase
  teardown do
    begin
    BackgroundJob.destroy
    rescue Errno::ENOENT
    end
  end

  test "should create submission for a task" do
    user = sign_in

    assert_difference "user.submissions.count", +1 do
      post :create, task_id: tasks(:hello_world).id, submission: { source: "puts 'Hello World'" }
    end

    assert_not_nil flash[:notice]
    assert_redirected_to task_path(tasks(:hello_world))
  end

  test "should fail empty submission for a task" do
    user = sign_in

    assert_difference "user.submissions.count", 0 do
      post :create, task_id: tasks(:hello_world).id, submission: { source: nil }
    end

    assert_not_nil flash[:error]
    assert_redirected_to task_path(tasks(:hello_world))
  end
end
