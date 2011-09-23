require 'spec_helper'

describe Oauth2::AuthorizationsController do
  describe 'routing' do
    it 'routes POST /oauth2/authorizations' do
      {:post => '/oauth2/authorizations'}.should route_to(:controller => 'oauth2/authorizations', :action => 'create')
    end
    it 'routes GET /oauth2/authorize' do
      {:get => '/oauth2/authorize'}.should route_to(:controller => 'oauth2/authorizations', :action => 'new')
    end
    it 'routes POST /oauth2/authorize' do
      {:post => '/oauth2/authorize'}.should route_to(:controller => 'oauth2/authorizations', :action => 'new')
    end
  end
end
