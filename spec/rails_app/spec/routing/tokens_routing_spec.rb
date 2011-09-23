require 'spec_helper'

describe Oauth2::TokensController do
  describe 'routing' do
    it 'routes POST /oauth2/token' do
      {:post => '/oauth2/token'}.should route_to(:controller => 'oauth2/tokens', :action => 'create')
    end
  end
end
