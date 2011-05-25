require 'devise/strategies/base'

module Devise
  module Strategies
    class Oauth2GrantTypeStrategy < Authenticatable
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
