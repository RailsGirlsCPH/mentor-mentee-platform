class CreateApiUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :api_users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :admin

      t.timestamps
    end
  end
end
