require 'spec_helper'

describe AccessToken do
  describe 'basic access token instance' do
    subject do
      client = Client.create! :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost'
      AccessToken.create! :client => client
    end
    it { should validate_presence_of :token }
    it { should validate_uniqueness_of :token }
    it { should belong_to :user }
    it { should belong_to :client }
    it { should validate_presence_of :client }
    it { should validate_presence_of :expires_at }
    it { should belong_to :refresh_token }
    it { should allow_mass_assignment_of :refresh_token }
    it { should have_db_index :client_id }
    it { should have_db_index :user_id }
    it { should have_db_index(:token).unique(true) }
    it { should have_db_index :expires_at }
  end

  describe 'refresh token expires before access token expires_at' do
    before do
      @soon = 1.minute.from_now
      client = Client.create! :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost'
      @refresh_token = client.refresh_tokens.create!
      @refresh_token.expires_at = @soon
      @access_token = AccessToken.create! :client => client, :refresh_token => @refresh_token
    end
    it 'should set the access token expires_at to equal refresh token' do
      @access_token.expires_at.should eq @soon
    end
  end
end

