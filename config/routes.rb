Devise::Oauth2Providable::Engine.routes.draw do
  root :to => "authorizations#new"

  resources :authorizations, :only => :create
  match 'authorize' => 'authorizations#new'
  resource :token, :only => :create
end

