Rails.application.routes.draw do
  scope '/oauth2', :as => 'oauth2' do
    resources :authorizations, :controller => 'oauth2/authorizations', :only => :create
    resource :token, :controller => 'oauth2/tokens', :only => :create
    match 'authorize' => 'oauth2/authorizations#new'
    
    resources :clients, :controller => 'oauth2/clients'
  end
end
