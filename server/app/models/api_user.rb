class ApiUser < ApplicationRecord
  # encrypt password
  has_secure_password
  

  # Can write model association here for example
  has_many :wishes, dependent: :destroy
  has_many :experiences, dependent: :destroy
  # validation

  validates_presence_of :email, :password_digest, :username
  validates :email, uniqueness: true, on: [:create, :update]
  validates :username, uniqueness: true, on: [:create, :update]
  validate :mentor_or_mentee


  def mentor_or_mentee
    unless mentor || mentee
      errors.add(:api_user, "must either want to be a mentor or mentee or both")
    end
  end

end


