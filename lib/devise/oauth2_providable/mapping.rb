
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
      attr_reader :scope_name, :path_prefix, :controllers, :models

      class << self
        def default_controllers
          {
            :authorizations => "devise/oauth2_providable/authorizations",
            :tokens         => "devise/oauth2_providable/tokens"
          }
        end

        def default_models
          {
            :access_token   => 'Devise::Oauth2Providable::AccessToken',
            :client         => 'Devise::Oauth2Providable::Client',
            :refresh_token  => 'Devise::Oauth2Providable::RefreshToken',
            :user           => 'User',
          }
        end
      end

      def initialize(scope_name, options = {})
        @scope_name  = (options[:scope_name] || scope_name.to_s.singularize).to_sym
        @path_prefix = options[:path_prefix]
        @controllers = self.select_controllers(options)
        @models      = self.select_models(options)
      end

      # Returns the devise scope mapping object associated with this oauth endpoint
      def devise_scope
        Devise.mappings[self.scope_name]
      end

      protected
      def select_controllers(options)
        self.class.default_controllers.merge(options[:controllers] || {})
      end

      def select_models(options)
        models = self.class.default_models.merge(self.scope_config[:models] || {})

        models.each { |key,value| models[key] = value.constantize }
      end

      def scope_config
        ::Rails.application.config.devise_oauth2_providable.scope_settings[@scope_name] || {}
      end
    end
  end
end
