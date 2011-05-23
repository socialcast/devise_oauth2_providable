class AddPetColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :pet, :string
  end

  def self.down
    remove_column :users, :pet
  end
end
