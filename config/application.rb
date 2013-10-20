require File.expand_path('../boot', __FILE__)

require 'jdbc/sqlite3'
require 'activerecord-jdbcsqlite3-adapter'
require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'rails/test_unit/railtie'
require 'sprockets/railtie'
require 'jquery-rails'
require 'turbolinks'

module Contestrus
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/jobs)
  end
end
