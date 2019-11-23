class Meetinginterval < ApplicationRecord
  has_many :wishes
  validates_presence_of :interval
end
