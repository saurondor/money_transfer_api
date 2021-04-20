class CreateCheckingAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :checking_accounts do |t|
      t.string :clabe, null: false, limit: 18
      t.integer :status, default: 1
      t.float :balance, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
