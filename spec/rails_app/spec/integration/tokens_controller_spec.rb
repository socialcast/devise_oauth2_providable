require 'spec_helper'

describe Oauth2::TokensController do
  describe 'POST /oauth2/token' do
    # describe 'with grant_type=refresh_token' do
    #   context 'with valid params' do
    #     before do
    #       @user = User.create! :email => 'ryan@socialcast.com', :name => 'ryan sonnek', :password => 'test'
    #       @client = Client.create! :name => 'example', :redirect_uri => 'http://localhost', :website => 'http://localhost'
    #       @refresh_token = @client.refresh_tokens.create! :user => @user
    #       params = {
    #         :grant_type => 'refresh_token',
    #         :client_id => @client.identifier,
    #         :client_secret => @client.secret,
    #         :refresh_token => @refresh_token.token
    #       }

    #       post '/oauth2/token', params
    #     end
    #     it { response.code.to_i.should == 200 }
    #     it { should assign_to(:access_token) }
    #     it 'returns json' do
    #       token = assigns(:access_token)
    #       refresh_token = @refresh_token
    #       expected = {
    #         :token_type => 'bearer',
    #         :expires_in => 899,
    #         :refresh_token => refresh_token.token,
    #         :access_token => token.token
    #       }
    #       response.body.should == expected.to_json
    #     end
    #   end
    # end

    describe 'with grant_type=password' do
      context 'with valid params' do
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
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          token = AccessToken.last
          expected = token.token_response
          response.body.should == expected.to_json
        end
      end
      context 'with invalid params' do
        before do
          @user = User.create! :email => 'ryan@socialcast.com', :name => 'ryan sonnek', :password => 'test'
          @client = Client.create! :name => 'example', :redirect_uri => 'http://localhost', :website => 'http://localhost'

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
            :error_description => "The provided access grant is invalid, expired, or revoked (e.g. invalid assertion, expired authorization token, bad end-user password credentials, or mismatching authorization code and redirection URI).",
            :error => "invalid_grant"
          }
          response.body.should == expected.to_json
        end
      end
    end
  end
end
