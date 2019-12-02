require 'rails_helper'

RSpec.describe ApiUser, type: :model do
  # Association test
  # ensure an item record has 1:m relationship with the *** model
  it { should have_many(:wishes).dependent(:destroy) }

  # Validation test
  # ensure columns 'email' and 'password' are present before

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:username)}

end
