class AuthorizationCode < ActiveRecord::Base
  include Oauth2Token

  def access_token
    @access_token ||= expired! && user.access_tokens.create(:client => client)
  end
end
