Rails.application.secrets.secret_key_base = ENV['SECRET_KEY_BASE'] if Rails.env.production?
