class AddExtraNotesToApiUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :api_users, :extra_notes, :string
  end
end
