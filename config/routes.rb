Rails.application.routes.draw do |map|
  require 'token_endpoint'
  post 'oauth2/token', :to => proc { |env| TokenEndpoint.new.call(env) }
end
