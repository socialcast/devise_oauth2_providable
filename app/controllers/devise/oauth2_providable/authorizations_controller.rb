module Devise
  module Oauth2Providable
    class AuthorizationsController < ApplicationController
      # If the devise internal helpers aren't loaded in the controller then it
      # has trouble resolving scope on the DeviseHelper module
      include ::Devise::Controllers::InternalHelpers
      include Devise::Oauth2Providable::Controllers::Helpers
      before_filter :authenticate_scope!

      rescue_from Rack::OAuth2::Server::Authorize::BadRequest do |e|
        @error = e
        render :error, :status => e.status
      end

      def new
        respond *authorize_endpoint.call(request.env)
      end

      def create
        respond *authorize_endpoint(:allow_approval).call(request.env)
      end

      private

      def respond(status, header, response)
        ["WWW-Authenticate"].each do |key|
          headers[key] = header[key] if header[key].present?
        end
        if response.redirect?
          redirect_to header['Location']
        else
          render :new
        end
      end

      def authorize_endpoint(allow_approval = false)
        Rack::OAuth2::Server::Authorize.new do |req, res|
          @client = Client.find_by_identifier(req.client_id) || req.bad_request!
          res.redirect_uri = req.verify_redirect_uri!(@client.redirect_uri)
          if allow_approval
            if params[:approve].present?
              case req.response_type
              when :code
                authorization_code = current_user.authorization_codes.create!(:client => @client)
                res.code = authorization_code.token
              when :token
                access_token = current_user.access_tokens.create!(:client => @client).token
                bearer_token = Rack::OAuth2::AccessToken::Bearer.new(:access_token => access_token)
                res.access_token = bearer_token
                res.uid = resource.id
              end
              res.approve!
            else
              req.access_denied!
            end
          else
            @response_type = req.response_type
          end
        end
      end
    end
  end
end
