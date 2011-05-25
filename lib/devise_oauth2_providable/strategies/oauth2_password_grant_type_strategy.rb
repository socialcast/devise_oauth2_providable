require 'devise/strategies/base'

module Devise
  module Strategies
    class GrantTypeStrategy < Authenticatable
      def valid?
        params[:controller] == 'oauth2/tokens' && request.post? && params[:grant_type] == self.grant_type
      end

      # defined by subclass
      def grant_type
      end

      def client
        @client ||= Client.find_by_identifier params[:client_id]
      end
    end
  end
end
module Devise
  module Strategies
    class Oauth2PasswordGrantTypeStrategy < GrantTypeStrategy
      def grant_type
        'password'
      end

      def authenticate!
        resource = mapping.to.find_for_authentication(mapping.to.authentication_keys.first => params[:username])
        if client && validate(resource) { resource.valid_password?(params[:password]) }
          success! resource
        elsif !halted?
          fail(:invalid_password_grant)
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_password_grant_type, Devise::Strategies::Oauth2PasswordGrantTypeStrategy)
