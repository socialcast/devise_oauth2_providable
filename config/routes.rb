require 'token_endpoint'
Rails.application.routes.draw do |map|
  scope '/oauth2', :name_prefix => 'oauth2' do
    resources :authorizations, :controller => 'oauth2/authorizations', :only => :create
    resource :token, :controller => 'oauth2/tokens', :only => :create
    match 'authorize' => 'oauth2/authorizations#new'
  end
end
