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

    assert_redirected_to user_path(User.find_by_username("whatever"))
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
  
  test "forbidden on showing user when not signed in" do
    get :show, id: users(:sirup).id
    assert_response :redirect
  end

  test "success  on user when signed in" do
    sign_in
    get :show, id: users(:sirup).id
    assert_response :success
  end
end
