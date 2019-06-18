class AddFirstNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
  end
end
