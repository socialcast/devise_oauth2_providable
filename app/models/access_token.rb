require 'expirable_token'
require 'mongoid_expirable_token'

class AccessToken
  include Mongoid::Document
  include ExpirableToken
  include MongoidExpirableToken
  
  self.default_lifetime = 1.month

  before_validation :restrict_expires_at, :if => :refresh_token  
  belongs_to :refresh_token
  
  field :token
  field :expires_at, :type => DateTime
    
  def token_response
    response = {
      :access_token => token,
      :token_type => 'bearer',
      :expires_in => expires_in,
      :user_id => self.user._id
    }
    response[:refresh_token] = refresh_token.token if refresh_token
    response
  end

  private

  def restrict_expires_at
    self.expires_at = [self.expires_at, refresh_token.expires_at].min
  end
end
