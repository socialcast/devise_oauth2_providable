require 'spec_helper'

describe TokenEndpoint do
  describe 'password grant type' do
    before do
      @user = User.create! :email => 'ryan@socialcast.com', :name => 'ryan sonnek', :password => 'test'
      @client = Client.create! :name => 'example', :redirect_uri => 'http://localhost', :website => 'http://localhost'

      params = {
        :grant_type => 'password',
        :client_id => @client.identifier,
        :client_secret => @client.secret,
        :username => @user.email,
        :password => 'test'
      }

      post '/oauth2/token', params
    end
    it { response.code.should == 200 }
    it { response.body.should == {}.to_json }
  end
end
