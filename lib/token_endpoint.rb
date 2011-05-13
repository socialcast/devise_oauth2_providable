class TokenEndpoint

  def call(env)
    authenticator.call(env)
  end

  private

  def authenticator
    Rack::OAuth2::Server::Token.new do |req, res|
      client = Client.find_by_identifier(req.client_id) || req.invalid_client!
      client.secret == req.client_secret || req.invalid_client!

      refresh_token = refresh_token(req, client)
      if refresh_token && token = refresh_token.access_tokens.create(:client => client, :user => refresh_token.user)
        res.access_token = token.to_bearer_token
      else
        req.invalid_grant!
      end
    end
  end

  # NOTE: extended assertion grant_types are not supported yet.
  # NOTE: client_credentials grant_types are not yet supported
  def refresh_token(req, client)
    case req.grant_type
    when :authorization_code
      code = AuthorizationCode.valid.find_by_token(req.code)
      return nil unless code.valid_request?(req)
      client.refresh_tokens.create! :user => code.user
    when :password
      resource = mapping.to.find_for_authentication(mapping.to.authentication_keys.first => req.username)
      return nil unless resource && resource.respond_to?(:valid_password?)
      valid = resource.valid_for_authentication? { resource.valid_password?(req.password) }
      return nil unless valid.is_a?(TrueClass)
      client.refresh_tokens.create! :user => resource
    when :refresh_token
      refresh_token = client.refresh_tokens.valid.find_by_token(req.refresh_token)
      return nil unless refresh_token.present?
      refresh_token
    else
      nil
    end
  end
  def mapping
    Devise.mappings[scope]
  end
  #TODO: allow configurable mapping to other resources
  def scope
    :user
  end
end
