require 'expirable_token'

class RefreshToken < ActiveRecord::Base
  include ExpirableToken
  self.default_lifetime = 1.month
  has_many :access_tokens
end
