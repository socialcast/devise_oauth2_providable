require 'spec_helper'

describe ProtectedController do

  describe 'get :index' do
    before do
      client = Client.create! :name => 'test', :redirect_uri => 'http://localhost:3000', :website => 'http://localhost'
      @user = User.create! :name => 'ryan sonnek', :email => 'foo@example.com'
      @token = AccessToken.create! :client => client, :user => @user

      get :index, {:bearer_token => @token.token}, {'HTTP_AUTHORIZATION' => "Bearer #{@token.token}"}
    end
    it { should respond_with :ok }
  end
end
