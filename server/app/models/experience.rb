class Experience < ApplicationRecord
  belongs_to :api_user
  belongs_to :programminglanguage
  delegate :language, to: :programminglanguage
  belongs_to :meetinginterval
  delegate :interval, to: :meetinginterval
  validates_presence_of :qualification
  validates_presence_of :api_user_id
  validate :validate_mentee
  validate :online_or_offline

  def online_or_offline
    return unless (available_offline == false) && (available_online == false)

    errors.add(:api_user, 'must be available either online or offline to complete experience')
  end

  def validate_mentee
    return unless api_user.nil? || api_user.mentor == false

    errors.add(:api_user, 'if you are creating an experience you must be a mentor')
  end
end
