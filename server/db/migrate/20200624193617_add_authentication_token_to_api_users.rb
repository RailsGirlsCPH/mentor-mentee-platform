class AddAuthenticationTokenToApiUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :api_users, :authentication_token, :string, limit: 30
    add_index :api_users, :authentication_token, unique: true
  end
end
