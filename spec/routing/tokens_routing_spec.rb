require 'spec_helper'

describe Devise::Oauth2Providable::TokensController do
  describe 'routing' do
    pending 'routes POST /oauth2/token' do
      post('/oauth2/token').should route_to('devise/oauth2_providable/tokens#create')
    end
  end
end
