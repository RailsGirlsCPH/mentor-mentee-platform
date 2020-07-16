class AmendEmailColumnInApiUser < ActiveRecord::Migration[6.0]
  def change
    change_column :api_users, :email, :string, :default => "", :null => false
  end
end
