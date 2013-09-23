require 'test_helper'

class CompetitionsIntegrationTest < ActionDispatch::IntegrationTest
  test "show all competitions when signed in" do
    user = sign_in
    assert page.has_content?(competitions(:open).name)
    assert page.has_content?(competitions(:time_limited).name)
  end

  test "view a competition" do
    user = sign_in
    click_link competitions(:open).name
  end

  test "view a competition's tasks" do
    user = sign_in
    click_link competitions(:open).name

    task = competitions(:open).tasks.first

    assert page.has_content?(task.name), 
      "Page doesn't have task #{task.name}"
  end
end
