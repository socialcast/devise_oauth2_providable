module Devise
  module Strategies
    class Oauth2RefreshTokenGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        'refresh_token'
      end

      def authenticate!
        if client && refresh_token = client.refresh_tokens.valid.find_by_token(params[:refresh_token])
          success! refresh_token.user
        elsif !halted?
          fail(:invalid_refresh_token)
        end
      end
    end
  end
end
Warden::Strategies.add(:oauth2_password_grant_type, Devise::Strategies::Oauth2RefreshTokenGrantTypeStrategy)
