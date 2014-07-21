require 'pusher'
if config = ENV['PUSHER']
  Pusher.url = "http://#{config['PUSHER_KEY']}:#{config['PUSHER_SECRET']}@api.pusherapp.com/apps/#{config['PUSHER_APP_ID']}"
  Pusher.logger = Rails.logger
end
