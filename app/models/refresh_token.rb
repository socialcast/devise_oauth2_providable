require 'expirable_token'
require 'mongoid_expirable_token'

class RefreshToken
  include Mongoid::Document
  include ExpirableToken
  include MongoidExpirableToken
  
  self.default_lifetime = 1.month
  
  has_many :access_tokens

end
