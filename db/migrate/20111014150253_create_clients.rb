class CreateClients < ActiveRecord::Migration
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
  end

  def down
  end
end
