require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get instructions" do
    get :instructions
    assert_response :success
  end
end
