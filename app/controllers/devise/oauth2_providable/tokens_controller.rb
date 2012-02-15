class Devise::Oauth2Providable::TokensController < ApplicationController
  before_filter :check_ssl, :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    @refresh_token = oauth2_current_refresh_token || oauth2_current_client.refresh_tokens.create!(:user => current_user)
    @access_token = @refresh_token.access_tokens.create!(:client => oauth2_current_client, :user => current_user)
    render :json => @access_token.token_response
  end
  private
  def oauth2_current_client
   env[Devise::Oauth2Providable::CLIENT_ENV_REF]
  end
  def oauth2_current_refresh_token
    env[Devise::Oauth2Providable::REFRESH_TOKEN_ENV_REF]
  end

  def check_ssl
    if Rails.application.config.devise_oauth2_providable[:force_ssl] && !request.ssl?
      render :json => {:error => "SSL Required"}, :status => 403, :header => {'Content-Type' => 'application/json'}
    end
  end
end

