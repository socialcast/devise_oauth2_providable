class User < ActiveRecord::Base
  devise :database_authenticatable, :oauth2_providable, :oauth2_password_grantable, :oauth2_refresh_token_grantable
end
