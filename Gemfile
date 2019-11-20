source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 5.2.3'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'flutie'
gem 'hamburgers'
gem 'jbuilder', '~> 2.5'
gem 'material_icons'
gem 'pg', '>= 0.18', '< 2.0'
gem 'prismic.io', require: 'prismic'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'sendgrid-actionmailer'
gem 'sidekiq'
gem 'sidekiq-failures', '~> 1.0'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'awesome_print'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails', '~> 4.11'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers'
end

group :development do
  gem "letter_opener"
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
