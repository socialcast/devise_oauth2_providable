module Devise
  module Oauth2Providable
    class Engine < Rails::Engine
      engine_name 'oauth2'
      isolate_namespace Devise::Oauth2Providable
      initializer "devise_oauth2_providable.initialize_application" do |app|
        app.config.filter_parameters << :client_secret
      end
   end
  end
end
