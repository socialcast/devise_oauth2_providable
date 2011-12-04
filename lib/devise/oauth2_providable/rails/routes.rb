
module Devise
  module Oauth2Providable
    module Rails
      module Routes
        def devise_oauth_for(scope, options = {})
          mapping = Devise::Oauth2Providable.add_mapping(scope, options)

          path_prefix = mapping.path_prefix
          as          = mapping.scope_name
          constraints = {}
          defaults    = {}

          devise_scope mapping.scope_name do
            scope(:as => "#{as}_oauth", :path => path_prefix) do
              devise_oauth_authorization_routes(mapping, mapping.controllers)
              devise_oauth_token_routes(mapping, mapping.controllers)
            end
          end
        end

        protected
        def devise_oauth_authorization_routes(mapping, controllers)
          controller = controllers[:authorizations]

          root :controller => controller, :action => 'new'

          resources :authorizations, :only => :create,
            :controller => controller

          match 'authorize', :controller => controller, :action => 'new'
        end

        def devise_oauth_token_routes(mapping, controllers)
          controller = controllers[:tokens]

          resource :token, :only => :create, :controller => controller
        end
      end
    end
  end
end

ActionDispatch::Routing::Mapper.class_eval do
  include Devise::Oauth2Providable::Rails::Routes
end
