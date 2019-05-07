class CreateProgramminglanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :programminglanguages do |t|
      t.string :language

      t.timestamps
    end
  end
end
