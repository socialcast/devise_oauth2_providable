require 'spec_helper'

describe Devise::Oauth2Providable::TokensController do
  describe 'POST #create' do
    context 'with ssl enforced' do
      with :client
      with :user
      before do
        Devise::Oauth2Providable::Engine.config.devise_oauth2_providable.force_ssl = true
        @authorization_code = user.authorization_codes.create(:client_id => client, :redirect_uri => client.redirect_uri)
        @params = {
          :grant_type => 'authorization_code',
          :client_id => client.identifier,
          :client_secret => client.secret,
          :code => @authorization_code.token,
          :redirect_uri => client.redirect_uri,
          :use_route => 'devise_oauth2_providable'
        }
      end
      after do
        Devise::Oauth2Providable::Engine.config.devise_oauth2_providable.force_ssl = false
      end
      it "should raise error if request is not ssl" do
        post :create, @params
        response.status.should == 403
        response.body.should == {:error => "SSL Required"}.to_json
        response.content_type.should == "application/json"
      end
    end
  end
end

