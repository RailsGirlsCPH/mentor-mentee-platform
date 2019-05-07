class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.text :field_of_interest
      t.string :time_spent
      t.references :user, foreign_key: true
      t.references :programminglanguage, foreign_key: true
      t.timestamps
    end
  end
end
