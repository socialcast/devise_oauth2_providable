require 'devise/oauth2_providable/strategies/oauth2_grant_type_strategy'

module Devise
  module Strategies
    class Oauth2PasswordGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        'password'
      end

      def authenticate_grant_type(client)
        resource = mapping.to.find_for_authentication(mapping.to.authentication_keys.first => params[:username])
        if validate(resource) { resource.valid_password?(params[:password]) }
          success! resource
        else
          oauth_error! :invalid_grant, 'invalid password authentication request'
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_password_grantable, Devise::Strategies::Oauth2PasswordGrantTypeStrategy)
