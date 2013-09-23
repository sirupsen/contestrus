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
    user
  end
end

# require 'capybara/poltergeist'
# Capybara.current_driver = :poltergeist

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def sign_in(user = users(:sirup), password = 'seekrit')
    visit root_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: password

    click_button 'Sign in'

    user
  end

  private
  def work_off_jobs
    job = BackgroundJob.shift
    Localjob::Worker.new(queue: ContestrusQueueName, logger: Logger.new("/dev/null")).process(job)
  end
end
