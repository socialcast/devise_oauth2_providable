require 'expirable_token'
require 'mongoid_expirable_token'

class AuthorizationCode
  include Mongoid::Document
  include ExpirableToken
  include MongoidExpirableToken
  
  field :redirect_uri
  field :token
  field :expires_at, :type => DateTime
  
  def access_token
    @access_token ||= expired! && user.access_tokens.create(:client => client)
  end
  
  def valid_request?(req)
    self.redirect_uri == req.redirect_uri
  end
end
