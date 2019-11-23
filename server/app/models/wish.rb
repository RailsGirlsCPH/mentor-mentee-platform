class Wish < ApplicationRecord
  belongs_to :api_user
  belongs_to :programminglanguage
  # has_one :programminglanguage, class_name: 'Programminglanguage', foreign_key: 'programminglanguage_id'
  delegate :language, :to => :programminglanguage
  # validation
  validates_presence_of :goal
  validate :online_or_offline

  def online_or_offline
    if (available_offline == false)  && (available_online == false)
      errors.add(:api_user, "must be available either online or offline to complete wish")
    end
  end

end
