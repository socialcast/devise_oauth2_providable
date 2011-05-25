require 'expirable_token'

class AccessToken < ActiveRecord::Base
  include ExpirableToken
  self.default_lifetime = 15.minutes

  before_validation :restrict_expires_at, :if => :refresh_token
  belongs_to :refresh_token

  def token_response
    response = {
      :access_token => token,
      :token_type => 'bearer',
      :expires_in => expires_in
    }
    response.merge!(:refresh_token => refresh_token.token) if refresh_token
    response
  end

  private

  def restrict_expires_at
    self.expires_at = [self.expires_at, refresh_token.expires_at].min
  end
end
