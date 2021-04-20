class CreateClabeAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :clabe_accounts do |t|
      t.string :abm_code
      t.string :short_name
      t.text :corporate_name

      t.timestamps
    end
    add_index(:clabe_accounts, :abm_code)
  end
end
