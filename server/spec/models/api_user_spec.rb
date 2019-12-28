require 'rails_helper'

RSpec.describe ApiUser, type: :model do
  # Association test
  # ensure an item record has 1:m relationship with the *** model

  describe 'validations' do 
    subject {build(:api_user, mentor: false, mentee: false)}

  # Validation test
    it { should have_many(:wishes).dependent(:destroy) }
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:email).on(:create)}
    it {should validate_uniqueness_of(:email).on(:update)} 
    it {should validate_uniqueness_of(:username).on(:create)}
    it {should validate_uniqueness_of(:username).on(:update)}
    it 'validations custom' do
      api_user1 = ApiUser.new(mentor: false, mentee: false)
      expect(api_user1).to be_invalid
      expect(api_user1.errors.full_messages).to include('Api user must either want to be a mentor or mentee or both')
    end
  end
end
