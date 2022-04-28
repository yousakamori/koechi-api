require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    # cookie
    config.middleware.use ActionDispatch::Cookies
    # session
    config.middleware.use ActionDispatch::Session::CookieStore, {
      secure: Rails.env.production?,
      http_only: Rails.env.production?,
      expire_after: 180.days,
      key: '_koechi_session',
      same_site: 'Lax'
    }

    # locale
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]

    # active storage proxy
    config.middleware.use ActionDispatch::Flash

    # auto load lib dir
    config.paths.add Rails.root.join('lib').to_s, eager_load: true

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end

    # yaml config
    config.x.app = config_for(:application)

    # image processor
    config.active_storage.variant_processor = :mini_magick
  end
end
