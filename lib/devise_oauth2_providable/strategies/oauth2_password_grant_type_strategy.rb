require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2PasswordGrantTypeStrategy < Authenticatable
      def valid?
        params[:controller] == 'oauth2/tokens' && request.post? && params[:grant_type] == 'password'
      end

      def authenticate!
        client = Client.find_by_identifier params[:client_id]
        resource = mapping.to.find_for_authentication(mapping.to.authentication_keys.first => params[:username])
        if validate(resource) { resource.valid_password?(params[:password]) }
          success! resource
        elsif !halted?
          fail(:invalid_password_grant)
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_password_grant_type, Devise::Strategies::Oauth2PasswordGrantTypeStrategy)
