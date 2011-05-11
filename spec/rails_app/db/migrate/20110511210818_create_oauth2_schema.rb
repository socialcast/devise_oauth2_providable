class CreateOauth2Schema < ActiveRecord::Migration
  def self.up
    Devise::Oauth2Providable::Schema.up(self)
  end
  def self.down
    Devise::Oauth2Providable::Schema.down(self)
  end
end
