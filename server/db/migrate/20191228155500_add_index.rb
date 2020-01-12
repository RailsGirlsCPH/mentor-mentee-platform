class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :api_users,  [:email, :mentor, :mentee]

  end
end
