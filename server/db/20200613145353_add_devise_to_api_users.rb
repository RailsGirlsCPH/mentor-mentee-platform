class AddDeviseToApiUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :api_users, :encrypted_password, :string,  default: "", null: false
    add_column :api_users, :reset_password_token, :string
    add_column :api_users, :reset_password_sent_at, :datetime
    add_column :api_users, :remember_created_at, :datetime
    add_column :api_users, :sign_in_count, :integer, default: 0
    add_column :api_users, :current_sign_in_at, :datetime
    add_column :api_users, :last_sign_in_at, :datetime
    add_column :api_users, :current_sign_in_ip, :string
    add_column :api_users, :last_sign_in_ip, :string
    add_column :api_users, :confirmation_token, :string
    add_column :api_users, :confirmed_at, :datetime
    add_column :api_users, :confirmation_sent_at, :datetime
    add_column :api_users, :unconfirmed_email, :string
    add_column :api_users, :authentication_token, :string
    add_index :api_users, :authentication_token
    add_index :api_users, :confirmation_token
    add_index :api_users, :reset_password_token
  end
  
end
