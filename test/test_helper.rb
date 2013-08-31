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
end

require 'capybara/poltergeist'
Capybara.current_driver = :poltergeist

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
