if rollbar_config = APP_CONFIG["rollbar"]
  require "rollbar/rails"
  Rollbar.configure do |config|
    config.access_token = rollbar_config["access_token"]

    config.async_handler = proc { |payload|
      Thread.new do
        Rollbar.process_payload(payload)
      end
    }
  end
end
