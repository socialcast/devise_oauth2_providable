Rails.application.routes.draw do
  devise_for :users

  resources :protected

  devise_oauth_for :users, :path_prefix => 'oauth2'
end
