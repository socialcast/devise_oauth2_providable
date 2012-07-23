require 'devise/oauth2_providable/strategies/oauth2_grant_type_strategy'

module Devise
  module Strategies
    class Oauth2AuthorizationCodeGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        'authorization_code'
      end

      def authenticate_grant_type(client)
        if code = client.authorization_codes.find_by_token(params[:code])
          success! code.user
        else
          oauth_error! :invalid_grant, 'invalid authorization code request'
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_authorization_code_grantable, Devise::Strategies::Oauth2AuthorizationCodeGrantTypeStrategy)
