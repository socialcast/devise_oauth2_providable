require 'spec_helper'

describe Devise::Strategies::Oauth2PasswordGrantTypeStrategy do
  describe 'POST /oauth2/token' do
    describe 'with grant_type=password' do
      context 'with valid params' do
        before do
          @user = User.create! :email => 'ryan@socialcast.com', :password => 'test'
          @client = Devise::Oauth2Providable::Client.create! :name => 'example', :redirect_uri => 'http://localhost', :website => 'http://localhost'

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
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          token = Devise::Oauth2Providable::AccessToken.last
          expected = token.token_response
          response.body.should match_json(expected)
        end
      end
      context 'with invalid params' do
        before do
          @user = User.create! :email => 'ryan@socialcast.com', :password => 'test'
          @client = Devise::Oauth2Providable::Client.create! :name => 'example', :redirect_uri => 'http://localhost', :website => 'http://localhost'

          params = {
            :grant_type => 'password',
            :client_id => @client.identifier,
            :client_secret => @client.secret,
            :username => @user.email,
            :password => 'bar'
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 400 }
        it { response.content_type.should == 'application/json'  }
        it 'returns json' do
          expected = {
            :error_description => "invalid password authentication request",
            :error => "invalid_grant"
          }
          response.body.should match_json(expected)
        end
      end
      context 'with invalid client' do
        before do
          @user = User.create! :email => 'ryan@socialcast.com', :password => 'test'

          params = {
            :grant_type => 'password',
            :client_id => '123',
            :client_secret => 'invalid',
            :username => @user.email,
            :password => 'test'
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 400 }
        it { response.content_type.should == 'application/json'  }
        it 'returns json' do
          expected = {
            :error_description => "invalid password authentication request",
            :error => "invalid_grant"
          }
          response.body.should match_json(expected)
        end
      end
    end
  end
end
