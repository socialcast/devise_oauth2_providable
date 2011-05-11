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
  end
end

