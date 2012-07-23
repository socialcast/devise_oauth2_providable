class CreateDeviseOauth2ProvidableSchema < ActiveRecord::Migration
  def change
    create_table :oauth2_clients do |t|
      t.string :name
      t.string :redirect_uri
      t.string :website
      t.string :identifier
      t.string :secret
      t.timestamps
    end
    change_table :oauth2_clients do |t|
      t.index :identifier, :unique => true
    end

    create_table :oauth2_access_tokens do |t|
      t.belongs_to :user, :client, :refresh_token
      t.string :token
      t.datetime :expires_at
      t.timestamps
    end
    change_table :oauth2_access_tokens do |t|
      t.index :token, :unique => true
      t.index :expires_at
      t.index :user_id
      t.index :client_id
    end

    create_table :oauth2_refresh_tokens do |t|
      t.belongs_to :user, :client
      t.string :token
      t.datetime :expires_at
      t.timestamps
    end
    change_table :oauth2_refresh_tokens do |t|
      t.index :token, :unique => true
      t.index :expires_at
      t.index :user_id
      t.index :client_id
    end

    create_table :oauth2_authorization_codes do |t|
      t.belongs_to :user, :client
      t.string :token
      t.datetime :expires_at
      t.timestamps
    end
    change_table :oauth2_authorization_codes do |t|
      t.index :token, :unique => true
      t.index :expires_at
      t.index :user_id
      t.index :client_id
    end
  end
end
