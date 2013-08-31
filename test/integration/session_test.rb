require 'test_helper'

class SessionIntegrationTest < ActionDispatch::IntegrationTest
  test 'sign in with user' do
    visit '/'

    fill_in "Username", with: 'sirup'
    fill_in "Password", with: 'seekrit'

    click_button "Sign in"

    assert_equal '/competitions', current_path
  end

  test 'wrong password shows an error' do
    visit '/'

    fill_in "Username", with: 'sirup'
    fill_in "Password", with: 'somethingelse'

    click_button "Sign in"

    assert_equal '/sessions', current_path
    assert page.has_content?("Invalid credentials")
  end
end
