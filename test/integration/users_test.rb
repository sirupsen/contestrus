require 'test_helper'

class CompetitionsIntegrationTest < ActionDispatch::IntegrationTest
  test "sign up" do
    visit root_path

    click_link "Sign up"

    fill_in "Username", with: "Sirupsen"
    fill_in "Email", with: "simon@sirupsen.com"
    fill_in "Password", with: "seekrit"

    click_button "Sign up"

    assert_equal competitions_path, page.current_path
  end

  test "show errors on invalid sign up" do
    visit root_path

    click_link "Sign up"

    fill_in "Username", with: ""
    fill_in "Email", with: "simon@sirupsen.com"
    fill_in "Password", with: "seekrit"

    click_button "Sign up"

    assert page.has_content? "Username can't be blank"
  end
end
