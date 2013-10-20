source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'foreman', '0.63.0'
gem 'sqlite3', "1.3.8"
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', "3.0.4"
gem 'turbolinks', "1.3.0"
gem 'bcrypt-ruby', '~> 3.0.0'
gem "kramdown"
gem "delayed_job", "4.0.0"
gem "daemons", "1.1.9"
gem 'delayed_job_active_record', "4.0.0"
gem "docker-api", :git => "git://github.com/swipely/docker-api.git", :require => 'docker'

group :test, :development do
  gem 'pry', '0.9.12.2'
end

group :test do
  gem 'capybara', '2.1.0'
end

group :production do
  gem 'puma'
end
