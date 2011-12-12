require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2GrantTypeStrategy < Authenticatable
      include Devise::Oauth2Providable::StrategyHelpers

      def valid?
        params[:controller] == 'devise/oauth2_providable/tokens' && request.post? && params[:grant_type] == grant_type
      end

      # defined by subclass
      def grant_type
      end

      def client
        return @client if @client
        @client = devise_oauth_mapping.models[:client].find_by_identifier_and_secret(params[:client_id], params[:client_secret])
        env[Devise::Oauth2Providable::CLIENT_ENV_REF] = @client
        @client
      end
      # return custom error response in accordance with the oauth spec
      # see http://tools.ietf.org/html/draft-ietf-oauth-v2-16#section-4.3
      def oauth_error!(error_code = :invalid_request, description = nil)
        body = {:error => error_code}
        body[:error_description] = description if description
        custom! [400, {'Content-Type' => 'application/json'}, [body.to_json]]
      end

      protected
      def devise_oauth_mapping
        env[Devise::Oauth2Providable::MAPPING_ENV_REF]
      end
    end
  end
end
