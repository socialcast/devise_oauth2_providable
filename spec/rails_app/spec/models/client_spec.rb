require 'spec_helper'

describe Client do
  describe 'basic client instance' do
    before { @client = Client.create :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost' }
    it { should validate_presence_of :name }
    it { should validate_presence_of :website }
    it { should validate_presence_of :redirect_uri }
  end
end
