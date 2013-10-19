require File.expand_path('../boot', __FILE__)

require 'daemons'
require 'sqlite3'
require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'rails/test_unit/railtie'
require 'sprockets/railtie'
require 'jquery-rails'
require 'turbolinks'

module Contestrus
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/jobs)
  end
end
