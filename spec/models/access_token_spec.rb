require 'spec_helper'

describe Devise::Oauth2Providable::AccessToken do
  it { Devise::Oauth2Providable::AccessToken.table_name.should == 'oauth2_access_tokens' }

  describe 'basic access token instance' do
    with :client
    subject do
      Devise::Oauth2Providable::AccessToken.create! :client => client
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

  describe '#expires_at' do
    context 'when refresh token does not expire before access token' do
      with :client
      before do
        @later = 1.year.from_now
        @refresh_token = client.refresh_tokens.create!
        @refresh_token.expires_at = @soon
        @access_token = Devise::Oauth2Providable::AccessToken.create! :client => client, :refresh_token => @refresh_token
      end
      focus 'should not set the access token expires_at to equal refresh token' do
        @access_token.expires_at.should_not == @later
      end
    end
    context 'when refresh token expires before access token' do
      with :client
      before do
        @soon = 1.minute.from_now
        @refresh_token = client.refresh_tokens.create!
        @refresh_token.expires_at = @soon
        @access_token = Devise::Oauth2Providable::AccessToken.create! :client => client, :refresh_token => @refresh_token
      end
      it 'should set the access token expires_at to equal refresh token' do
        @access_token.expires_at.should == @soon
      end
    end
  end
end
