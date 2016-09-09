require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DraftAppApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Insert some middlewares in order for OmniAuth to work
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # Setup Active Job Adapter
    config.active_job.queue_adapter = :sidekiq

    # Skip before action for SessionsController
    config.to_prepare do
      DeviseTokenAuth::SessionsController.skip_before_action :authenticate_user!
    end

    # Use selective stack middleware to enable the session middleware when
    # the URL does not start with /api/
    # config.middleware.insert_before ActionDispatch::ParamsParser, 'SelectiveStack'

    # Rack Cors configuration
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          expose: %w(access-token expiry token-type uid client),
          methods: %i(get post options delete put)
      end
    end
  end
end
