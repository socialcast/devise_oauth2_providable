require 'token_endpoint'
Rails.application.routes.draw do |map|
  namespace 'oauth2' do
    resources :authorizations, :only => :create
    resource :token, :only => :create
  end

  match 'oauth2/authorize' => 'oauth2/authorizations#new'
end
