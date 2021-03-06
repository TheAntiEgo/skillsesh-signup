require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Signup
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # Mailer Settings
    config.action_mailer.default_url_options = Rails.env == 'production' ? {:host => 'skillsesh.com'} : {:host => 'tape-hilton.codio.io:3000'}
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address => 'smtp-relay.gmail.com',
      :port => 587,
      :domain => 'skillsesh.com',
      :user_name => 'notifications@skillsesh.com',
      :password => Rails.application.secrets.gmail_password,
      :authentication => 'plain',
      :enable_starttls_auto => true
    }
  end
end
