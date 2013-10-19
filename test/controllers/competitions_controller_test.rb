require 'test_helper'

class CompetitionsControllerTest < ActionController::TestCase
  test "non-admin users do not have access to leaderboard during competition" do
    sign_in users(:bob)
    competition = competitions(:ongoing)

    get :leaderboard, id: competition

    assert_response :forbidden
  end

  test "admin users have access to leaderboard during competition" do
    sign_in
    competition = competitions(:ongoing)

    get :leaderboard, id: competition

    assert_response :success
  end

  test "non-admin users have access to results of past competitions" do
    sign_in users(:bob)
    competition = competitions(:past)

    get :leaderboard, id: competition

    assert_response :success
  end
end
