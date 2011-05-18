require 'spec_helper'

describe ProtectedController do

  describe 'get :index' do
    before do
      client = Client.create! :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost'
      @user = User.create! :name => 'ryan sonnek', :email => 'foo@example.com'
      @token = AccessToken.create! :client => client, :user => @user
    end
    context 'with valid bearer token in header' do
      before do
        @request.env['HTTP_AUTHORIZATION'] = "Bearer #{@token.token}"
        get :index, :format => 'json'
      end
      it { should respond_with :ok }
    end
    context 'with invalid bearer token in query param' do
      before do
        get :index, :bearer_token => 'invalid', :format => 'json'
      end
      it { should respond_with :unauthorized }
    end
    context 'with valid bearer token in header and query string' do
      before do
        @request.env['HTTP_AUTHORIZATION'] = "Bearer #{@token.token}"
        get :index, :bearer_token => @token.token, :format => 'json'
      end
      it { should respond_with :unauthorized }
    end
  end
end
