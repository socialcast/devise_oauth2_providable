module Devise
  module Oauth2Providable
    class Engine < Rails::Engine
      config.devise_oauth2_providable = ActiveSupport::OrderedOptions.new
      config.devise_oauth2_providable.access_token_expires_in       = 15.minutes
      config.devise_oauth2_providable.refresh_token_expires_in      = 1.month
      config.devise_oauth2_providable.authorization_code_expires_in = 1.minute

      engine_name 'oauth2'
      isolate_namespace Devise::Oauth2Providable
      initializer "devise_oauth2_providable.initialize_application", :before=> :load_config_initializers do |app|
        app.config.filter_parameters << :client_secret
      end
    end
  end
end
