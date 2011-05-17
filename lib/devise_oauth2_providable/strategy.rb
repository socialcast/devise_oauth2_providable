require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2Providable < Base
      def valid?
        env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN].present?
      end
      def authenticate!
        token = AccessToken.valid.find_by_token env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN]
        resource = token.user
        if validate(resource)
          success! resource
        elsif !halted?
          fail(:invalid_token)
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_providable, Devise::Strategies::Oauth2Providable)
