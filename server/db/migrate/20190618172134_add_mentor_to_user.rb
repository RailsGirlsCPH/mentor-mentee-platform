class AddMentorToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mentor, :boolean
  end
end
