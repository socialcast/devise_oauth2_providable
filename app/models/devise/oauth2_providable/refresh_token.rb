class Devise::Oauth2Providable::RefreshToken < ActiveRecord::Base
  expires_according_to :refresh_token_expires_in

  attr_accessible :user, :client

  has_many :access_tokens
end
