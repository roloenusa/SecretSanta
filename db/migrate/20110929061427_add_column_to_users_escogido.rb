class AddColumnToUsersEscogido < ActiveRecord::Migration
  def self.up
    add_column :users, :escogido, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :users, :escogido
  end
end
