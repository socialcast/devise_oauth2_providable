require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2Providable < Authenticatable
      include Devise::Oauth2Providable::StrategyHelpers

      def valid?
        @req = Rack::OAuth2::Server::Resource::Bearer::Request.new(env)
        @req.oauth2?
      end
      def authenticate!
        @req.setup!
        token = oauth_models[:access_token].find_by_token @req.access_token
        env[Devise::Oauth2Providable::CLIENT_ENV_REF] = token.client if token
        resource = token ? token.user : nil
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
