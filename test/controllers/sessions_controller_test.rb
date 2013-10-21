require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should sign in user" do
    post :create, user: {
      username: "sirup",
      password: "seekrit"
    }

    assert_equal users(:sirup).id, session[:user_id]
    assert_redirected_to user_path(users(:sirup))
  end

  test "should flash error on incorrect password" do
    u = users(:sirup)

    post :create, user: {
      username: "sirup",
      password: "mmh"
    }

    assert_not_nil flash[:error]
    assert_template :new
  end

  test "redirect to user when already signed in" do
    sign_in

    get :new

    assert_redirected_to user_path(users(:sirup))
  end
end
