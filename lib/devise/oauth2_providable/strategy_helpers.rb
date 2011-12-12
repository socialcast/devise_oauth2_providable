
module Devise
  module Oauth2Providable
    module StrategyHelpers
      protected
      def oauth_mapping
        Devise::Oauth2Providable.mappings[mapping.name]
      end

      def oauth_models
        self.oauth_mapping.models
      end
    end
  end
end
