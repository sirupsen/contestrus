require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "#time_left_badge on an open competition returns nil" do
    assert_match /Open/, time_left_badge(competitions(:open))
  end

  test "#time_left_badge for an ongoing competition returns time remaining" do
    assert_match /1:49:/, time_left_badge(competitions(:ongoing))
  end

  test "#time_left_badge for an expired competition returns completed" do
    assert_match /Completed/, time_left_badge(competitions(:past))
  end
end
