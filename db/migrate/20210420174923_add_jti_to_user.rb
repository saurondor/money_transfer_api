class AddJtiToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true
  end

  def down
    remove_index :users, :jti
    remove_column :users, :jti
  end
end
