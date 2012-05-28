Devise::Oauth2Providable::Engine.routes.draw do
  root :to => "authorizations#new"

  resources :authorizations, :only => :create
  get 'authorize' => 'authorizations#new'
  post 'authorize' => 'authorizations#new'
  resource :token, :only => :create
end

