require 'token_endpoint'
Rails.application.routes.draw do
  namespace 'oauth2' do
    resources :authorizations, :only => :create
  end

  match 'oauth2/authorize' => 'oauth2/authorizations#new'
  post 'oauth2/token' => TokenEndpoint.new
end
