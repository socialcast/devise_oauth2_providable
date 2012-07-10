require 'spec_helper'

describe Devise::Strategies::Oauth2AuthorizationCodeGrantTypeStrategy do
  describe 'POST /oauth2/token' do
    describe 'with grant_type=authorization_code' do
      context 'with valid params' do
        with :client
        with :user
        before do
          @authorization_code = user.authorization_codes.create!(:client => client, :redirect_uri => client.redirect_uri)
          params = {
            :grant_type => 'authorization_code',
            :client_id => client.identifier,
            :client_secret => client.secret,
            :code => @authorization_code.token
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 200 }
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          token = Devise::Oauth2Providable::AccessToken.last
          refresh_token = Devise::Oauth2Providable::RefreshToken.last
          expected = {
            :token_type => 'bearer',
            :expires_in => 899,
            :refresh_token => refresh_token.token,
            :access_token => token.token
          }
          response.body.should match_json(expected)
        end
      end
      context 'with expired authorization_code' do
        with :client
        with :user
        before do
          timenow = 2.days.from_now
          Time.stub!(:now).and_return(timenow)
          @authorization_code = user.authorization_codes.create(:client_id => client, :redirect_uri => client.redirect_uri)
          params = {
            :grant_type => 'authorization_code',
            :client_id => client.identifier,
            :client_secret => client.secret,
            :code => @authorization_code.token
          }
          Time.stub!(:now).and_return(timenow + 10.minutes)

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 400 }
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          expected = {
            :error => 'invalid_grant',
            :error_description => 'invalid authorization code request'
          }
          response.body.should match_json(expected)
        end
      end
      context 'with invalid authorization_code' do
        with :client
        with :user
        before do
          @authorization_code = user.authorization_codes.create(:client_id => client, :redirect_uri => client.redirect_uri)
          params = {
            :grant_type => 'authorization_code',
            :client_id => client.identifier,
            :client_secret => client.secret,
            :code => 'invalid'
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 400 }
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          expected = {
            :error => 'invalid_grant',
            :error_description => 'invalid authorization code request'
          }
          response.body.should match_json(expected)
        end
      end
      context 'with invalid client_secret' do
        with :user
        with :client
        before do
          @authorization_code = user.authorization_codes.create(:client_id => client, :redirect_uri => client.redirect_uri)
          params = {
            :grant_type => 'authorization_code',
            :client_id => client.identifier,
            :client_secret => 'invalid',
            :code => @authorization_code.token
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 400 }
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          expected = {
            :error => 'invalid_client',
            :error_description => 'invalid client credentials'
          }
          response.body.should match_json(expected)
        end
      end
      context 'with invalid client_id' do
        with :user
        with :client
        before do
          @authorization_code = user.authorization_codes.create(:client_id => client, :redirect_uri => client.redirect_uri)
          params = {
            :grant_type => 'authorization_code',
            :client_id => 'invalid',
            :client_secret => client.secret,
            :code => @authorization_code.token
          }

          post '/oauth2/token', params
        end
        it { response.code.to_i.should == 400 }
        it { response.content_type.should == 'application/json' }
        it 'returns json' do
          expected = {
            :error => 'invalid_client',
            :error_description => 'invalid client credentials'
          }
          response.body.should match_json(expected)
        end
      end
    end
  end
end

