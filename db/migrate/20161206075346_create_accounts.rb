class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :account_number
      t.integer :account_id
      t.decimal :balance
      t.string :status

      t.timestamps null: false
    end
  end
end
