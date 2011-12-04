Rails.application.routes.draw do
  devise_for :users

  resources :protected

  devise_scope :user do
    mount Devise::Oauth2Providable::Engine => '/oauth2'
  end
end
