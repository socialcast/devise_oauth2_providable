class TokenEndpoint
  class InvalidGrantType < StandardError; end
  def call(env)
    authenticator.call(env)
  end

  private

  def authenticator
    Rack::OAuth2::Server::Token.new do |req, res|
      client = Client.find_by_identifier(req.client_id)
      req.invalid_client! unless client && client.secret == req.client_secret
      begin
        res.access_token = access_token(req, client).to_bearer_token
      rescue => e
        puts e.inspect
        req.invalid_grant!
      end
    end
  end

  def access_token(req, client)
    refresh_token = find_refresh_token(req, client)
    refresh_token.access_tokens.create!(:client => client, :user => refresh_token.user)
  end

  # NOTE: extended assertion grant_types are not supported yet.
  # NOTE: client_credentials grant_types are not yet supported
  def find_refresh_token(req, client)
    case req.grant_type
    when :authorization_code
      code = AuthorizationCode.valid.find_by_token(req.code)
      raise InvalidGrantType.new('invalid authorization code') unless code && code.valid_request?(req)
      client.refresh_tokens.create! :user => code.user
    when :password
      conditions = Hash.new
      mapping.to.authentication_keys.each do |key|
        conditions[key] = req.env["rack.request.form_hash"][key.to_s]
      end
      conditions[:email] = req.username
      resource = mapping.to.find_for_authentication(conditions)
      raise InvalidGrantType.new('user not found') unless resource
      raise InvalidGrantType.new('user does not support password authentication') unless resource.respond_to?(:valid_password?)
      valid = resource.valid_for_authentication? { resource.valid_password?(req.password) }
      raise InvalidGrantType.new("authentication failed: #{valid}") unless valid.is_a?(TrueClass)
      client.refresh_tokens.create! :user => resource
    when :refresh_token
      refresh_token = client.refresh_tokens.valid.find_by_token(req.refresh_token)
      raise InvalidGrantType.new('refresh token not found') unless refresh_token
      refresh_token
    else
      raise InvalidGrantType.new('invalid grant type')
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
