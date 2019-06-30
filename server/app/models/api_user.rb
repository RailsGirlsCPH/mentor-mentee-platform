class ApiUser < ApplicationRecord
  # encrypt password
  #has_secure_password


  # Can write model association here for example
  #h has_many :***, dependent: :destroy

  # validation
  validates_presence_of :email, :password_digest
end

