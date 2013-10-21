require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "show all tasks" do
    sign_in

    get :index

    assert_response :success
  end

  test "should not show task for future competition" do
    sign_in

    get :show, id: tasks(:future_hello_world).id

    assert_response :forbidden
  end

  test "should show task for ongoing competition" do
    sign_in

    get :show, id: tasks(:ongoing_hello_world).id

    assert_response :success
  end
end
