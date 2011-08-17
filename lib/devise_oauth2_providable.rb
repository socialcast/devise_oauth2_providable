require 'devise'
require 'rack/oauth2'
require 'devise_oauth2_providable/strategy'
require 'devise_oauth2_providable/model'
require 'devise_oauth2_providable/schema'
require 'devise_oauth2_providable/engine'

module Devise
  module Oauth2Providable
    class << self
      def random_id
        SecureRandom.hex
      end
    end
  end
end

Devise.add_module(:oauth2_providable,
  :strategy => true,
  :model => 'devise_oauth2_providable/model')

