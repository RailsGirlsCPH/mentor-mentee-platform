class DeletePasswordDigestColumnInApiUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :api_users, :password_digest, :string
  end
end
