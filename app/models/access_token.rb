require 'expirable_token'

class AccessToken < ActiveRecord::Base
  include ExpirableToken
  self.default_lifetime = 15.minutes

  before_validation :restrict_expires_at, :if => :refresh_token
  belongs_to :refresh_token

  def to_bearer_token
    bearer_token = Rack::OAuth2::AccessToken::Bearer.new :access_token => self.token, :expires_in => self.expires_in
    if refresh_token
      bearer_token.refresh_token = refresh_token.token
    end
    bearer_token
  end

  private

  def restrict_expires_at
    self.expires_at = [self.expires_at, refresh_token.expires_at].min
  end
end
