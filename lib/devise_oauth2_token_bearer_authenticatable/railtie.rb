require 'rails'

module Devise
  module Oauth2TokenBearerAuthenticatable
    class Railtie < ::Rails::Railtie
      initializer "devise_oauth2_token_bearer_authenticatable.initialize_application" do |app|
        ActiveSupport::Dependencies.autoload_paths << File.join(File.dirname(__FILE__), '..', '..', 'app', 'models')
        ActiveSupport::Dependencies.autoload_once_paths << File.join(File.dirname(__FILE__), '..', '..', 'app', 'models')
        app.middleware.use Rack::OAuth2::Server::Resource::Bearer, 'OAuth2 Bearer Token Resources' do |req|
          AccessToken.valid.find_by_token(req.access_token) || req.invalid_token!
        end
      end
    end
  end
end
