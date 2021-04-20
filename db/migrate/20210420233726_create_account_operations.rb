class CreateAccountOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :account_operations do |t|
      t.references :checking_account, null: false, foreign_key: true
      t.string :operation_type, limit:10, null: false
      t.string :auth_code, limit:6
      t.float :amount, null: false
      t.string :clabe
      t.string :description
      t.string :operation_status, null: false, limit:10

      t.timestamps
    end
  end
end
