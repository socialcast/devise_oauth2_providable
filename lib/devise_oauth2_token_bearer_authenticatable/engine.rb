module Devise
  module Oauth2TokenBearerAuthenticatable
    class Engine < Rails::Engine
      initializer "devise_oauth2_token_bearer_authenticatable.initialize_application" do |app|
        app.middleware.use Rack::OAuth2::Server::Resource::Bearer, 'OAuth2 Bearer Token Resources' do |req|
          AccessToken.valid.find_by_token(req.access_token) || req.invalid_token!
        end
      end
    end
  end
end

