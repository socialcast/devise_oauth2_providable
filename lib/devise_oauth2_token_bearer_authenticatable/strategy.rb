require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2TokenBearerAuthenticatable < Base
      def valid?
        env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN].present?
      end
      def authenticate!
        token = AccessToken.valid.find_by_token env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN]
        raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized unless token
        raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized.new(:invalid_token, 'User token is required') unless token.user
        success! token.user
      end
    end
  end
end

Warden::Strategies.add(:oauth2_token_bearer_authenticatable, Devise::Strategies::Oauth2TokenBearerAuthenticatable)
