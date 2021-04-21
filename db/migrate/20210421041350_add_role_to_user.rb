class AddRoleToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :role, :string, :limit => 10, :default => 'holder', :null => false
  end

  def down
    remove_column :users, :role
  end
end
