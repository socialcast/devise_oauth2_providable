require 'token_endpoint'
Rails.application.routes.draw do |map|
  namespace 'oauth2' do
    resources :authorizations, :only => :create
  end
  match 'oauth2/authorize', :to => 'oauth2/authorizations#new'
  post 'oauth2/token', :to => proc { |env| TokenEndpoint.new.call(env) }
end
