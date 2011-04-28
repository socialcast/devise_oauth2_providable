require 'spec_helper'
require 'token_endpoint'
require 'active_record'
require File.join(File.dirname(__FILE__), '..', 'app', 'models', 'client')

describe TokenEndpoint do
  #FIXME
  describe 'refresh_token grant type' do
    before do
      params = {
        :grant_type => 'refresh_token',
        :client_id => 'client_id',
        :code => 'authorization_code',
        :redirect_uri => 'http://client.example.com/callback'
      }

      request = Rack::MockRequest.new TokenEndpoint.new
      @response = request.post('/', :params => params)
    end
    it 'should create new access token' do

    end
    it { @response.status.should == 200 }
    it { @response.content_type.should == 'application/json' }
    it { @response.body.should include '"access_token"' }
  end
end
