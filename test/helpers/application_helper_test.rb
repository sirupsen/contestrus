require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "#time_left_badge on an open competition returns nil" do
    refute time_left_badge(competitions(:open))
  end

  test "#time_left_badge for an ongoing competition returns time remaining" do
    assert_match /1:49:/, time_left_badge(competitions(:ongoing))
  end

  test "#time_left_badge for an expired competition returns completed" do
    assert_match /Completed/, time_left_badge(competitions(:past))
  end

  test "#time_left_badge for an upcoming competition returns returns time to contest starts" do
    assert_match /0:9:5/, time_left_badge(competitions(:future))
  end
end
