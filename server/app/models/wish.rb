class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :programminglanguage
  belongs_to :meetingfreq
end
