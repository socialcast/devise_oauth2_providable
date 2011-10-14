require 'devise'
require 'rack/oauth2'
require 'devise/oauth2_providable/engine'
require 'devise/oauth2_providable/strategies/oauth2_providable_strategy'
require 'devise/oauth2_providable/strategies/oauth2_password_grant_type_strategy'
require 'devise/oauth2_providable/strategies/oauth2_refresh_token_grant_type_strategy'
require 'devise/oauth2_providable/strategies/oauth2_authorization_code_grant_type_strategy'
require 'devise/oauth2_providable/models/oauth2_providable'
require 'devise/oauth2_providable/models/oauth2_password_grantable'
require 'devise/oauth2_providable/models/oauth2_refresh_token_grantable'
require 'devise/oauth2_providable/models/oauth2_authorization_code_grantable'

module Devise
  module Oauth2Providable
    class << self
      def random_id
        SecureRandom.hex
      end
      def table_name_prefix
        'oauth2_'
      end
    end
  end
end

Devise.add_module(:oauth2_providable,
  :strategy => true,
  :model => 'devise/oauth2_providable/models/oauth2_providable')
Devise.add_module(:oauth2_password_grantable, 
  :strategy => true,
  :model => 'devise/oauth2_providable/models/oauth2_password_grantable')
Devise.add_module(:oauth2_refresh_token_grantable, 
  :strategy => true,
  :model => 'devise/oauth2_providable/models/oauth2_refresh_token_grantable')
Devise.add_module(:oauth2_authorization_code_grantable,
  :strategy => true,
  :model => 'devise/oauth2_providable/models/oauth2_authorization_code_grantable')
