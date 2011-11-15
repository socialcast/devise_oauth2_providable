class Devise::Oauth2Providable::TokensController < ApplicationController
  before_filter :clear_session
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    @refresh_token = oauth2_current_refresh_token || oauth2_current_client.refresh_tokens.create!(:user => current_user)
    @access_token = @refresh_token.access_tokens.create!(:client => oauth2_current_client, :user => current_user)
    render :json => @access_token.token_response
  end
  
  def destroy
    oauth2_current_refresh_token.destroy if oauth2_current_refresh_token

    oauth2_current_access_token.destroy if oauth2_current_access_token
    
    head :deleted
  end

  private
  # clear the session, so devise does not use session cookie based auth in any case
  # the iPhone SDK by default has a shared cookie jar for WebViews and NSURL Request's
  # and thus will send a cookie to this method
  def clear_session
    session.clear
  end  
  
  def oauth2_current_client
   env[Devise::Oauth2Providable::CLIENT_ENV_REF]
  end

  def oauth2_current_access_token
    env[Devise::Oauth2Providable::ACCESS_TOKEN_ENV_REF]
  end
  
  def oauth2_current_refresh_token
    env[Devise::Oauth2Providable::REFRESH_TOKEN_ENV_REF]
  end
end
