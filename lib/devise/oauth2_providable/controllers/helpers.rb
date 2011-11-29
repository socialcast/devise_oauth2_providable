
module Devise
  module Oauth2Providable
    module Controllers
      module Helpers
        extend ActiveSupport::Concern

        module ClassMethods
          include Devise::Controllers::InternalHelpers
          include LocalInstanceMethods
        end

        module LocalInstanceMethods
          # Authenticates the current scope and gets the current resource from the session.
          # Taken from devise
          def authenticate_scope!
            send(:"authenticate_#{resource_name}!", :force => true)
            self.resource = send(:"current_#{resource_name}")
          end
        end
      end
    end
  end
end
