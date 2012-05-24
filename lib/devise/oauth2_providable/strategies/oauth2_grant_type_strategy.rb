require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2GrantTypeStrategy < Authenticatable
      def valid?
        env['action_controller.instance'].kind_of?(Devise::Oauth2Providable::TokensController) && request.post? && params[:grant_type] == grant_type
      end

      # defined by subclass
      def grant_type
      end

      # defined by subclass
      def authenticate_grant_type(client)
      end

      def authenticate!
        client_id, client_secret = request.authorization ? decode_credentials : [params[:client_id], params[:client_secret]]
        client = Devise::Oauth2Providable::Client.find_by_identifier client_id
        if client && client.secret == client_secret
          env[Devise::Oauth2Providable::CLIENT_ENV_REF] = client
          authenticate_grant_type(client)
        else
          oauth_error! :invalid_client, 'invalid client credentials'
        end
      end

      # return custom error response in accordance with the oauth spec
      # see http://tools.ietf.org/html/draft-ietf-oauth-v2-16#section-4.3
      def oauth_error!(error_code = :invalid_request, description = nil)
        body = {:error => error_code}
        body[:error_description] = description if description
        custom! [400, {'Content-Type' => 'application/json'}, [body.to_json]]
      end
    end
  end
end
