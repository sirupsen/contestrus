require File.expand_path('../boot', __FILE__)

require 'daemons'
require 'sqlite3'
require 'rails/all'
require 'jquery-rails'
require 'turbolinks'

module Contestrus
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/jobs)
  end
end
