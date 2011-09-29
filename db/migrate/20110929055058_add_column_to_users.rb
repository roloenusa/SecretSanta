class AddColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :amigo, :integer
  end

  def self.down
    remove_column :users, :amigo
  end
end
