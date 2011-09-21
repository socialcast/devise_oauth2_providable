require 'expirable_token'
require 'mongoid_expirable_token'

class RefreshToken
  include Mongoid::Document
  include ExpirableToken
  include MongoidExpirableToken
  
  self.default_lifetime = 3.months
  
  has_many :access_tokens

  field :token
  field :expires_at, :type => DateTime
  
end
