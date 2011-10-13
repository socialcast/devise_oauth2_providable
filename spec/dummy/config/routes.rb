Rails.application.routes.draw do
  mount Devise::Oauth2Providable::Engine => "/oauth2"
end
