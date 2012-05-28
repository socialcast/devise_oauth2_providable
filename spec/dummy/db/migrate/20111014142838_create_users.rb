class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # database_authenticable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.timestamps
    end
  end
end
