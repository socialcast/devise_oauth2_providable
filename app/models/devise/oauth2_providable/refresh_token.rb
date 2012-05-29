class Devise::Oauth2Providable::RefreshToken < ActiveRecord::Base
  expires_according_to :refresh_token_expires_in

  has_many :access_tokens, :dependent => :delete_all
end
