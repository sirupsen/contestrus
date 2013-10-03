require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "renders new" do
    get :new
    assert_response :success
  end

  test "create new user" do
    assert_difference "User.count", +1 do
      post :create, { 
        user: {
          email: "simon@what.com",
          username: "whatever",
          password: "seekrit"
        }
      }
    end

    assert_redirected_to competitions_path
  end

  test "dont create user on failing validation" do
    assert_no_difference "User.count" do
      post :create, { 
        user: {
          email: "simon@what.com",
          username: "whatever",
          password: nil
        }
      }
    end

    assert_template :new
  end
end
