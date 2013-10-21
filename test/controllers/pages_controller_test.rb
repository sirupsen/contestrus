require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get instructions" do
    sign_in
    get :instructions
    assert_response :success
  end
end
