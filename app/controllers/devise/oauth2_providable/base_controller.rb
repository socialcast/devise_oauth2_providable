class Devise::Oauth2Providable::BaseController < ApplicationController
  before_filter :authenticate_user!
end
