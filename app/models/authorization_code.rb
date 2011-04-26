require 'expirable_token'

class AuthorizationCode < ActiveRecord::Base
  include ExpirableToken

  def access_token
    @access_token ||= expired! && user.access_tokens.create(:client => client)
  end
end
