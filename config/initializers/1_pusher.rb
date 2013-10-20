require 'pusher'
if config = APP_CONFIG['pusher']
  Pusher.url = "http://#{config['key']}:#{config['secret']}@api.pusherapp.com/apps/#{config['app_id']}"
  Pusher.logger = Rails.logger
end
