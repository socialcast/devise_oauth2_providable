require 'spec_helper'

describe User do
  describe 'basic user instance' do
    before { @user = User.create :name => 'ryan sonnek' }
    it { should have_many :access_tokens }
  end
end
