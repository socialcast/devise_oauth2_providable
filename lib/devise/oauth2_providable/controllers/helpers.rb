
module Devise
  module Oauth2Providable
    module Controllers
      module Helpers

        # Authenticates the current scope and gets the current resource from the session.
        # Taken from devise
        def authenticate_scope!
          send(:"authenticate_#{resource_name}!", :force => true)
          self.resource = send(:"current_#{resource_name}")
        end
        def devise_oauth_mapping
          @devise_oauth_mapping ||= request.env[Devise::Oauth2Providable::MAPPING_ENV_REF]
        end
      end
    end
  end
end
