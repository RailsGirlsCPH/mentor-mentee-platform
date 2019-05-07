class CreateWishes < ActiveRecord::Migration[5.2]
  def change
    create_table :wishes do |t|
      t.integer :availability
      t.boolean :available_offline
      t.boolean :available_online
      t.string :goal
      t.references :user, foreign_key: true
      t.references :programminglanguage, foreign_key: true
      t.references :meetingfreq, foreign_key: true

      t.timestamps
    end
  end
end
