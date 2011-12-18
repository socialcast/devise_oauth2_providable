
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

        def scope_name(scope_name, options={})
          (options[:scope_name] || scope_name.to_s.singularize).to_sym
        end
      end

      attr_reader :scope_name, :path_prefix, :controllers, :models

      def initialize(scope_name, options = {})
        @scope_name  = self.class.scope_name(scope_name, options)
        @models      = self.class.default_models
        @controllers = self.class.default_controllers
        apply_options(options)
      end

      def apply_options(options)
        @path_prefix = options[:path_prefix]
        @controllers = self.select_controllers(options)
        @models      = self.select_models(options)
        self
      end

      # Returns the devise scope mapping object associated with this oauth endpoint
      def devise_scope
        Devise.mappings[self.scope_name]
      end

      def access_token
        models[:access_token].constantize
      end

      def client
        models[:client].constantize
      end

      def refresh_token
        models[:refresh_token].constantize
      end

      def user
        models[:user].constantize
      end

      protected
      def select_controllers(options)
        @controllers.merge(options[:controllers] || {})
      end

      def select_models(options)
        models = @models.merge(options[:models] || self.scope_config[:models] || {})
      end

      def scope_config
        ::Rails.application.config.devise_oauth2_providable.scope_settings[@scope_name] || {}
      end
    end
  end
end
