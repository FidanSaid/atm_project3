class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
