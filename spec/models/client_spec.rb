require 'spec_helper'

describe Devise::Oauth2Providable::Client do
  it { Devise::Oauth2Providable::Client.table_name.should == 'oauth2_clients' }

  describe 'basic client instance' do
    subject { Devise::Oauth2Providable::Client.create! :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost' }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should allow_mass_assignment_of :name }
    it { should validate_presence_of :website }
    it { should allow_mass_assignment_of :website }
    it { should validate_presence_of :redirect_uri }
    it { should allow_mass_assignment_of :redirect_uri }
    it { should validate_uniqueness_of :identifier }
    it { should have_db_index(:identifier).unique(true) }
    it { should_not allow_mass_assignment_of :identifier }
    it { should_not allow_mass_assignment_of :secret }
    it { should have_many :refresh_tokens }
  end
end
