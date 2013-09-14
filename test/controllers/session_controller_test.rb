require 'test_helper'

class SessionControllerTest < ActionController::TestCase
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
    assert_redirected_to competitions_path
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
end
