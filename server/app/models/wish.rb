class Wish < ApplicationRecord
  belongs_to :api_user
  belongs_to :programminglanguage
  delegate :language, :to => :programminglanguage
  belongs_to :meetinginterval
  delegate :interval, :to => :meetinginterval
  # validation
  validates_presence_of :goal
  validate :online_or_offline

  def online_or_offline
    if (available_offline == false)  && (available_online == false)
      errors.add(:api_user, "must be available either online or offline to complete wish")
    end
  end

end
