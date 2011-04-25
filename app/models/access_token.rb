require 'oauth2_token'

class AccessToken < ActiveRecord::Base
  include Oauth2Token
  self.default_lifetime = 15.minutes
  belongs_to :refresh_token

  def to_bearer_token(with_refresh_token = false)
    bearer_token = Rack::OAuth2::AccessToken::Bearer.new(
      :access_token => self.token,
      :expires_in => self.expires_in
    )
    if with_refresh_token
      bearer_token.refresh_token = self.create_refresh_token(
        :user => self.user,
        :client => self.client
      ).token
    end
    p bearer_token.token_response
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
