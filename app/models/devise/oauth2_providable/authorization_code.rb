class Devise::Oauth2Providable::AuthorizationCode < ActiveRecord::Base
  expires_according_to :authorization_code_expires_in

  def access_token
    @access_token ||= expired! && user.access_tokens.create(:client => client)
  end
  def valid_request?(req)
    self.redirect_uri == req.redirect_uri
  end
end
