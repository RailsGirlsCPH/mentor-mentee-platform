class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.string :prog_lang
      t.text :field_of_interest
      t.string :time_spent
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
