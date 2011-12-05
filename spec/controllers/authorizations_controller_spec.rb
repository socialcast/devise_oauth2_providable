require 'spec_helper'

describe Devise::Oauth2Providable::AuthorizationsController do
  describe 'GET #new' do
    with :user
    with :client
    before do
      sign_in user
      get :new, :client_id => client.identifier, :redirect_uri => client.redirect_uri, :response_type => 'code', :use_route => 'devise_oauth2_providable'
    end
    it { should respond_with :ok }
    it { should respond_with_content_type :html }
    it { should assign_to(:redirect_uri) }
    it { should assign_to(:response_type) }
  end
end
