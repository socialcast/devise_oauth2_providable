require 'spec_helper'

describe Devise::Oauth2Providable::RefreshToken do
  it { Devise::Oauth2Providable::RefreshToken.table_name.should == 'oauth2_refresh_tokens' }

  describe 'basic refresh token instance' do
    subject do
      client = Devise::Oauth2Providable::Client.create! :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost'
      Devise::Oauth2Providable::RefreshToken.create! :client => client
    end
    it { should validate_presence_of :token }
    it { should validate_uniqueness_of :token }
    it { should belong_to :user }
    it { should belong_to :client }
    it { should validate_presence_of :client }
    it { should validate_presence_of :expires_at }
    it { should have_many :access_tokens }
    it { should have_db_index :client_id }
    it { should have_db_index :user_id }
    it { should have_db_index(:token).unique(true) }
    it { should have_db_index :expires_at }
  end
end
