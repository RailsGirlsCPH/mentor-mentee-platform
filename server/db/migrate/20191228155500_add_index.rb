# This migration adds index to api users
class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :api_users, %i[email mentor mentee]
  end
end
