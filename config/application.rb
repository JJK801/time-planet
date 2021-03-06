require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TimePlanet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :fr
    config.i18n.available_locales = [:fr, :en]
    config.i18n.fallbacks = [:en, :fr]

    config.active_job.queue_adapter = :sidekiq

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.view_specs        false
      g.controller_specs  false
      g.helper_specs      false
      g.helper            false
      g.assets            false
      g.stylesheets       false
      g.javascripts       false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
