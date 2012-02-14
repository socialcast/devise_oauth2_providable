require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2GrantTypeStrategy < Authenticatable
      def valid?
        params[:controller] == 'devise/oauth2_providable/tokens' && request.post? && params[:grant_type] == grant_type
      end

      # defined by subclass
      def grant_type
      end

      def client
        return @client if @client
        @client = Devise::Oauth2Providable::Client.find_by_identifier params[:client_id]
        if @client && @client.secret == params[:client_secret]
          env[Devise::Oauth2Providable::CLIENT_ENV_REF] = @client
          return @client
        end
        return nil
      end
      # return custom error response in accordance with the oauth spec
      # see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-5.2
      def oauth_error!(error_code = :invalid_request, description = nil)
        body = {:error => error_code}
        body[:error_description] = description if description
        custom! [400, {'Content-Type' => 'application/json'}, [body.to_json]]
      end
    end
  end
end

