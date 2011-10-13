Devise::Oauth2Providable::Engine.routes.draw do
  resources :authorizations, :only => :create
  resource :token, :only => :create

  # scope '/oauth2', :as => 'oauth2' do
  #   resources :authorizations, :controller => 'oauth2/authorizations', :only => :create
  #   match 'authorize' => 'oauth2/authorizations#new'
  #   resource :token, :controller => 'oauth2/tokens', :only => :create
  # end
end
