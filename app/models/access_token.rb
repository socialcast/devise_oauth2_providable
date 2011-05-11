require 'expirable_token'

class AccessToken < ActiveRecord::Base
  include ExpirableToken
  self.default_lifetime = 15.minutes
  attr_accessor :refresh_token

  def to_bearer_token(with_refresh_token = false)
    bearer_token = Rack::OAuth2::AccessToken::Bearer.new(
      :access_token => self.token,
      :expires_in => self.expires_in
    )
    if with_refresh_token
      refresh_token = client.refresh_tokens.create! :user => self.user
      bearer_token.refresh_token = refresh_token.token
    end
    bearer_token
  end

  private

  def setup
    super
    if refresh_token
      self.user = refresh_token.user
      self.client = refresh_token.client
      self.expires_at = [self.expires_at, refresh_token.expires_at].min
    end
  end
end
