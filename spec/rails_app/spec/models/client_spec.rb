require 'spec_helper'

describe Client do
  describe 'basic client instance' do
    before { @client = Client.create :name => 'test', :redirect_uri => 'http://localhost:3000' }
    it { should validate_presence_of :name }
  end
end
