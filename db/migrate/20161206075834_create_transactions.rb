class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :debit
      t.decimal :amount
      t.string :merchandise_name
      t.integer :account_id
      t.integer :atm_machine_id

      t.timestamps null: false
    end
  end
end
