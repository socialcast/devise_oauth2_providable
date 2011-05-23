class User < ActiveRecord::Base
  devise :database_authenticatable, :oauth2_providable
  
  
  def self.find_for_authentication(conditions)
    user = find(:first, :readonly => false, :conditions => conditions)
    return user
  end
  
  def self.add_authentication_keys
    devise :authentication_keys => [:email, :pet]
  end
end
