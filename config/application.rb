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

    # yaml config
    config.x.app = config_for(:application)

    # cookie
    config.middleware.use ActionDispatch::Cookies

    # session
    session_params = {
      key: '_koechi_session',
      secure: Rails.env.production?,
      http_only: Rails.env.production?,
      expire_after: 180.days,
      same_site: 'Lax'
    }
    session_params[:domain] = '.koechi.com' if Rails.env.production?
    config.middleware.use ActionDispatch::Session::CookieStore, session_params

    # locale
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]

    # active storage proxy
    config.middleware.use ActionDispatch::Flash

    # auto load lib dir
    config.paths.add Rails.root.join('lib').to_s, eager_load: true

    # rspec
    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end

    # image processor
    config.active_storage.variant_processor = :mini_magick
  end
end
