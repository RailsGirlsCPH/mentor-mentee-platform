class CreateWishes < ActiveRecord::Migration[6.0]
  def change
    create_table :wishes do |t|
      t.boolean :available_offline
      t.boolean :available_online
      t.string :goal
      t.belongs_to :api_user, foreign_key: true #, index: { unique: true }
      t.references :programminglanguage
      t.references :meetinginterval
      t.timestamps
    end
  end
end
