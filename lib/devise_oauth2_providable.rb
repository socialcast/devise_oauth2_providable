require 'devise'
require 'rack/oauth2'
require 'devise_oauth2_providable/strategy'
require 'devise_oauth2_providable/model'
require 'devise_oauth2_providable/schema'
require 'devise_oauth2_providable/engine'
require 'devise_oauth2_providable/strategies/oauth2_password_grant_type_strategy'
require 'devise_oauth2_providable/strategies/oauth2_refresh_token_grant_type_strategy'
require 'devise_oauth2_providable/models/oauth2_password_grantable'
require 'devise_oauth2_providable/models/oauth2_refresh_token_grantable'

module Devise
  module Oauth2Providable
    class << self
      def random_id
        ActiveSupport::SecureRandom.hex
      end
    end
  end
end

Devise.add_module(:oauth2_providable,
  :strategy => true,
  :model => 'devise_oauth2_providable/model')
Devise.add_module(:oauth2_password_grantable, 
  :strategy => true,
  :model => 'devise_oauth2_providable/models/oauth2_password_grantable')
Devise.add_module(:oauth2_refresh_token_grantable, 
  :strategy => true,
  :model => 'devise_oauth2_providable/models/oauth2_refresh_token_grantable')
