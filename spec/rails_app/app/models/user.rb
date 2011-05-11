class User < ActiveRecord::Base
  devise :database_authenticatable, :oauth2_providable
end
