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
    it { response.code.to_i.should == 200 }
    it 'returns json' do
      token = AccessToken.last
      refresh_token = RefreshToken.last
      expected = {
        :token_type => 'bearer',
        :expires_in => 899,
        :refresh_token => refresh_token.token,
        :access_token => token.token
      }
        # "{\"token_type\":\"bearer\",\"expires_in\":899,\"refresh_token\":\"bzRiMusIUW5usXcm5h/1iw==\",\"access_token\":\"L/n1yMJiY0c3jxYhYyDdsA==\"}"
      response.body.should == expected.to_json
    end
  end
end
