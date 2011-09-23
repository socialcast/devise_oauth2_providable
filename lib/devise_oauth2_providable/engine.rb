module Devise
  module Oauth2Providable
    class Engine < Rails::Engine
      initializer "devise_oauth2_providable.initialize_application" do |app|
        app.config.filter_parameters << :client_secret
      end
    end
  end
end

