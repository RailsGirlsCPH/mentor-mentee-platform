class AddWorkStatusToApiUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :api_users, :work_status, :string
  end
end
