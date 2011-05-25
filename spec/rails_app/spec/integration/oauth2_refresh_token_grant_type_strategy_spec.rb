require 'spec_helper'

describe Devise::Strategies::Oauth2RefreshTokenGrantTypeStrategy do
  describe 'POST /oauth2/token' do
    describe 'with grant_type=refresh_token' do
      context 'with valid params' do
        before do
          @user = User.create! :email => 'ryan@socialcast.com', :name => 'ryan sonnek', :password => 'test'
          @client = Client.create! :name => 'example', :redirect_uri => 'http://localhost', :website => 'http://localhost'
          @refresh_token = @client.refresh_tokens.create! :user => @user
          params = {
            :grant_type => 'refresh_token',
            :client_id => @client.identifier,
            :client_secret => @client.secret,
            :refresh_token => @refresh_token.token
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 200 }
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          token = AccessToken.last
          refresh_token = @refresh_token
          expected = {
            :token_type => 'bearer',
            :expires_in => 899,
            :refresh_token => refresh_token.token,
            :access_token => token.token
          }
          response.body.should == expected.to_json
        end
      end
      context 'with invalid refresh_token' do
        before do
          @user = User.create! :email => 'ryan@socialcast.com', :name => 'ryan sonnek', :password => 'test'
          @client = Client.create! :name => 'example', :redirect_uri => 'http://localhost', :website => 'http://localhost'
          @refresh_token = @client.refresh_tokens.create! :user => @user
          params = {
            :grant_type => 'refresh_token',
            :client_id => @client.identifier,
            :client_secret => @client.secret,
            :refresh_token => 'invalid'
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 400 }
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          token = AccessToken.last
          refresh_token = @refresh_token
          expected = {}
          response.body.should == expected.to_json
        end
      end

    end
  end
end
