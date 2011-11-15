require 'spec_helper'

describe Devise::Oauth2Providable::TokensController do
  before :all do
    Devise::Oauth2Providable::Engine.load_engine_routes
  end
  describe 'routing' do
    it 'routes POST /oauth2/token' do
      post('/oauth2/token').should route_to('devise/oauth2_providable/tokens#create')
    end

    # it 'routes DELETE /oauth2/token' do
    #   post('/oauth2/token').should route_to('devise/oauth2_providable/tokens#destroy')
    # end
  end
end