require 'devise'
require 'rack/oauth2'
require 'devise_oauth2_token_bearer_authenticatable/strategy'
require 'devise_oauth2_token_bearer_authenticatable/model'
require 'devise_oauth2_token_bearer_authenticatable/schema'

module Devise
  module Oauth2TokenBearerAuthenticatable
  # Your code goes here...
    
  end
end

Devise.add_module(:oauth2_token_bearer_authenticatable,
  :strategy => true,
  :model => 'devise_oauth2_token_bearer_authenticatable/model')

