class AddLanguageToExperiences < ActiveRecord::Migration[5.2]
  def change
    add_reference :experiences, :language, foreign_key: true
  end
end
