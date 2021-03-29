# This migration creates meeting intervals table in database
class CreateMeetingintervals < ActiveRecord::Migration[6.0]
  def change
    create_table :meetingintervals do |t|
      t.string :interval
      t.timestamps
    end
  end
end
