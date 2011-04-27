require 'devise/schema'

module Devise
  module Oauth2Providable
    module Schema
      def self.up(migration)
        migration.create_table :clients do |t|
          t.string :name
          t.string :redirect_uri
          t.string :website
          t.string :identifier
          t.string :secret
          t.timestamps
        end
        migration.add_index :clients, :identifier

        migration.create_table :access_tokens do |t|
          t.belongs_to :user, :client
          t.string :token
          t.datetime :expires_at
          t.timestamps
        end
        migration.add_index :access_tokens, :token
        migration.add_index :access_tokens, :expires_at
        migration.add_index :access_tokens, :user_id
        migration.add_index :access_tokens, :client_id

        migration.create_table :refresh_tokens do |t|
          t.belongs_to :user, :client
          t.string :token
          t.datetime :expires_at
          t.timestamps
        end
        migration.add_index :refresh_tokens, :token
        migration.add_index :refresh_tokens, :expires_at
        migration.add_index :refresh_tokens, :user_id
        migration.add_index :refresh_tokens, :client_id

        migration.create_table :authorization_codes do |t|
          t.belongs_to :user, :client
          t.string :token
          t.datetime :expires_at
          t.string :redirect_uri
          t.timestamps
        end
        migration.add_index :authorization_codes, :token
        migration.add_index :authorization_codes, :expires_at
        migration.add_index :authorization_codes, :user_id
        migration.add_index :authorization_codes, :client_id
      end

      def self.down(migration)
        migration.drop_table :refresh_tokens
        migration.drop_table :access_tokens
        migration.drop_table :clients
      end
    end
  end
end

