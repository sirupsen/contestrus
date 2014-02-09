if opbeat_config = APP_CONFIG["opbeat"]
  require "opbeat"

  Opbeat.configure do |config|
    config.organization_id = opbeat_config["organization_id"]
    config.app_id          = opbeat_config["app_id"]
    config.secret_token    = opbeat_config["secret_token"]
  end
end
