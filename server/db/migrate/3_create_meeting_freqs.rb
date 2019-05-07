class CreateMeetingFreqs < ActiveRecord::Migration[5.2]
  def change
    create_table :meetingfreqs do |t|
      t.string :interval

      t.timestamps
    end
  end
end
