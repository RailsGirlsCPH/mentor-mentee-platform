class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.boolean :available_offline
      t.boolean :available_online
      t.string :qualification
      t.belongs_to :api_user, foreign_key: true
      t.references :programminglanguage
      t.references :meetinginterval
      t.timestamps
    end
  end
end
