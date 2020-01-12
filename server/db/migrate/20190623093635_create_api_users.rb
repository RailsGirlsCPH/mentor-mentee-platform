class CreateApiUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :api_users do |t|

      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :city
      t.string :email
      t.string :password_digest

      t.boolean :mentor, null: false
      t.boolean :mentee, null: false
      t.timestamps
    end
  end
end
