require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2Providable < Base
      def valid?
        @req = Rack::OAuth2::Server::Resource::Bearer::Request.new(env)
        @req.oauth2?
      end
      def authenticate!
        @req.setup!
        token = AccessToken.valid.find_by_token @req.access_token
        resource = token ? token.user : nil
        if validate(resource)
          success! resource
        elsif !halted?
          fail(:invalid_token)
        end
      end

      private
      # Simply invokes valid_for_authentication? with the given block and deal with the result.
      def validate(resource, &block)
        result = resource && resource.valid_for_authentication?(&block)

        case result
        when String, Symbol
          fail!(result)
          false
        when TrueClass
          true
        else
          result
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_providable, Devise::Strategies::Oauth2Providable)
