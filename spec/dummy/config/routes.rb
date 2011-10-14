Rails.application.routes.draw do
  devise_for :users

  resources :protected

  # mount Devise::Oauth2Providable::Engine
end
