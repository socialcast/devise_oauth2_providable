require 'active_support/concern'
require 'active_record'

module Devise
  module Oauth2Providable
    module ExpirableToken
      extend ActiveSupport::Concern

      module ClassMethods
        def expires_according_to(config_name)
          cattr_accessor :default_lifetime
          self.default_lifetime = Rails.application.config.devise_oauth2_providable[config_name]

          belongs_to :user
          belongs_to :client

          attr_accessible :user, :client

          after_initialize :init_token, :on => :create, :unless => :token?
          after_initialize :init_expires_at, :on => :create, :unless => :expires_at?
          validates :expires_at, :presence => true
          validates :client, :presence => true
          validates :token, :presence => true, :uniqueness => true

          default_scope lambda {
            where(self.arel_table[:expires_at].gteq(Time.now.utc))
          }

          include LocalInstanceMethods
        end
      end

      module LocalInstanceMethods
        # number of seconds until the token expires
        def expires_in
          (expires_at - Time.now.utc).to_i
        end

        # forcefully expire the token
        def expired!
          self.expires_at = Time.now.utc
          self.save!
        end

        private

        def init_token
          self.token = Devise::Oauth2Providable.random_id
        end
        def init_expires_at
          self.expires_at = self.default_lifetime.from_now
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Devise::Oauth2Providable::ExpirableToken
