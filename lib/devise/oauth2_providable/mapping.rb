
module Devise
  module Oauth2Providable
    # Responsible for mapping oauth endpoints onto devise scopes
    #
    # You must declare your devise scope before 
    #
    #   map.devise_oauth_for :users
    #
    #   mapping = Devise::Oauth2Providable.mappings[:user]
    #
    #   mapping.scope_name #=> :user
    #   # The name of the devise scope that this endpoint will use
    #
    #   mapping.devise_scope #=> Devise.mappings[:user]
    #   # Returns the devise scope associated with this mapping
    #
    #   mapping.prefix
    class Mapping
      attr_reader :scope_name, :path_prefix, :controllers

      class << self
        def default_controllers
          {
            :authorizations => "devise/oauth2_providable/authorizations",
            :tokens         => "devise/oauth2_providable/tokens"
          }
        end
      end

      def initialize(scope_name, options = {})
        @scope_name  = (options[:scope_name] || scope_name.to_s.singularize).to_sym
        @path_prefix = options[:path_prefix]
        @controllers = self.select_controllers(options)
      end

      # Returns the devise scope mapping object associated with this oauth endpoint
      def devise_scope
        Devise.mappings[self.scope_name]
      end

      protected
      def select_controllers(options)
        self.class.default_controllers.merge(options[:controllers] || {})
      end
    end
  end
end
