RSpec.describe ApiUser, type: :model do
  # Association test
  # ensure an item record has 1:m relationship with the *** model

  describe 'validations' do 
    subject {build(:api_user, mentor: false, mentee: false)}

  # Validation test
    it {is_expected.to have_many(:wishes).dependent(:destroy) }
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_presence_of(:password_digest)}
    it {is_expected.to validate_presence_of(:username)}
    it {is_expected.to validate_uniqueness_of(:email).on(:create)}
    it {is_expected.to validate_uniqueness_of(:email).on(:update)}
    it {is_expected.to validate_uniqueness_of(:username).on(:create)}
    it {is_expected.to validate_uniqueness_of(:username).on(:update)}
    it 'Custom Validation user should be a mentor or mentee' do
      api_user1 = ApiUser.new(mentor: false, mentee: false)
      expect(api_user1).to be_invalid
      expect(api_user1.errors.full_messages).to include('Api user must either want to be a mentor or mentee or both')
    end
  end
end
