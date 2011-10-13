class Devise::Oauth2Providable::TokensController < ApplicationController
  before_filter :authenticate_user!

  def create
    @refresh_token = oauth2_current_refresh_token || oauth2_current_client.refresh_tokens.create!(:user => current_user)
    @access_token = @refresh_token.access_tokens.create!(:client => oauth2_current_client, :user => current_user)
    render :json => @access_token.token_response
  end
  private
  def oauth2_current_client
   env['oauth2.client'] 
  end
  def oauth2_current_refresh_token
    env['oauth2.refresh_token']
  end
end
