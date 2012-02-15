require 'spec_helper'

describe Devise::Oauth2Providable::AuthorizationsController do
  describe 'GET #new' do
    context 'with valid redirect_uri' do
      with :user
      with :client
      let(:redirect_uri) { client.redirect_uri }
      before do
        sign_in user
        get :new, :client_id => client.identifier, :redirect_uri => redirect_uri, :response_type => 'code', :use_route => 'devise_oauth2_providable'
      end
      it { should respond_with :ok }
      it { should respond_with_content_type :html }
      it { should assign_to(:redirect_uri).with(redirect_uri) }
      it { should assign_to(:response_type) }
      it { should render_template 'devise/oauth2_providable/authorizations/new' }
      it { should render_with_layout 'application' }
    end
    context 'with invalid redirect_uri' do
      with :user
      with :client
      let(:redirect_uri) { 'http://example.com/foo/bar' }
      before do
        sign_in user
        get :new, :client_id => client.identifier, :redirect_uri => redirect_uri, :response_type => 'code', :use_route => 'devise_oauth2_providable'
      end
      it { should respond_with :bad_request }
      it { should respond_with_content_type :html }
    end
    context "with ssl enforced" do
      with :user
      with :client
      let(:redirect_uri) { client.redirect_uri }
      before do
        sign_in user
        Devise::Oauth2Providable::Engine.config.devise_oauth2_providable.force_ssl = true
      end
      after do
        Devise::Oauth2Providable::Engine.config.devise_oauth2_providable.force_ssl = false
      end
      it "should raise error if request is not ssl" do
        get :new, :client_id => client.identifier, :redirect_uri => redirect_uri, :response_type => 'code', :use_route => 'devise_oauth2_providable'
        response.status.should == 403
        response.body.should == {:error => "SSL Required"}.to_json
        response.content_type.should == "application/json"
      end
      it "should accept ssl requests" do
        request.env['HTTPS'] = 'on'
        get :new, :client_id => client.identifier, :redirect_uri => redirect_uri, :response_type => 'code', :use_route => 'devise_oauth2_providable'
        response.status.should == 200
      end
    end
  end
end

