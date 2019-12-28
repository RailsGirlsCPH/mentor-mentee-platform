class Wish < ApplicationRecord
  belongs_to :api_user
  belongs_to :programminglanguage
  delegate :language, :to => :programminglanguage
  belongs_to :meetinginterval
  delegate :interval, :to => :meetinginterval
  validates_presence_of :goal
  validates_presence_of :api_user_id
  validate :validate_mentee
  validate :online_or_offline

  #This method does not need to be called and will show the program that
  #tries to assign this value, this is the way figured out what was
  #happening with validate mentee
  # def api_user_id=(value)
  #   byebug
  #   super(value)
  # end 

  def online_or_offline
    if (available_offline == false) && (available_online == false)
      errors.add(:api_user, "must be available either online or offline to complete wish")
    end
  end

  def validate_mentee
    if (self.api_user.nil? || self.api_user.mentee == false)
      errors.add(:api_user, "if you are creating a wish you must be a mentee")
    end
  end
end


