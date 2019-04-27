class RemoveFieldNameFromExperiences < ActiveRecord::Migration[5.2]
  def change
    remove_column :experiences, :prog_lang, :string
  end
end
