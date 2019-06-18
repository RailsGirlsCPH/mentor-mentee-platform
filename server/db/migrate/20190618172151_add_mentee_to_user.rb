class AddMenteeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mentee, :boolean
  end
end
