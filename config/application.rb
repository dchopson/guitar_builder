require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GuitarBuilder
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

    config.assets.initialize_on_precompile = true
    config.autoload_paths << Rails.root.join('lib')

    config.after_initialize do
      if ENV['PAYPAL_LOGIN']
        mode = Rails.env.development? ? :test : Rails.env.to_sym
        ActiveMerchant::Billing::Base.mode = mode
        paypal_options = {
          :login => ENV['PAYPAL_LOGIN'],
          :password => ENV['PAYPAL_PASSWORD'],
          :signature => ENV['PAYPAL_SIGNATURE']
        }
        ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
      else
        puts 'WARNING: PayPal credentials needed for checkout process to work - see https://github.com/dchopson/guitar_builder#configuring-the-application'
      end
    end
  end
end
