require 'spec_helper'

describe Devise::Oauth2Providable::AuthorizationCode do
  describe 'basic authorization code instance' do
    with :client
    subject do
      Devise::Oauth2Providable::AuthorizationCode.create! :client => client
    end
    it { should validate_presence_of :token }
    it { should validate_uniqueness_of :token }
    it { should belong_to :user }
    it { should allow_mass_assignment_of :user }
    it { should belong_to :client }
    it { should allow_mass_assignment_of :client }
    it { should validate_presence_of :client }
    it { should validate_presence_of :expires_at }
    it { should have_db_index :client_id }
    it { should have_db_index :user_id }
    it { should have_db_index(:token).unique(true) }
    it { should have_db_index :expires_at }
  end
end

