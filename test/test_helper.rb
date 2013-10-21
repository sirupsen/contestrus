ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  fixtures :all

  def assert_invalid(record, message = nil)
    assert(!record.valid?, message || "Expected #{record} to be invalid.")
  end

  def sign_in(user = users(:sirup))
    session[:user_id] = user.id
    session[:session_hash] = user.session_hash
    user
  end
end

# require 'capybara/poltergeist'
# Capybara.current_driver = :poltergeist

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  teardown do
    sign_out
  end

  def sign_in(user = users(:sirup), password = 'seekrit')
    visit root_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: password

    click_button 'Sign in'

    user
  end

  def sign_out
    visit sessions_path
    click_button "Sign out"
  end
end
