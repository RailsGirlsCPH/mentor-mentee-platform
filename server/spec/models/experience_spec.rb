RSpec.describe Experience, type: :model do
  let!(:api_user){
    create(:api_user, mentee: true)}
  let!(:prog){create(:programminglanguage)}
  let!(:meet){create(:meetinginterval)}

  describe 'validations' do
    subject {create(:experience, api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id)}
    it {is_expected.to validate_presence_of(:qualification)}
    it {is_expected.to validate_presence_of(:api_user_id)}
    it {is_expected.to belong_to(:api_user)}
    it {is_expected.to belong_to(:programminglanguage)}
    it {is_expected.to belong_to(:meetinginterval)}
    it {is_expected.to delegate_method(:language).to(:programminglanguage)}
    it {is_expected.to delegate_method(:interval).to(:meetinginterval)}
    it "Custom Validation ensure user available offline or online" do
      experience1 = Experience.new(api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id, available_offline: false, available_online: false)
      expect(experience1).to be_invalid
      expect(experience1.errors.full_messages).to include('Api user must be available either online or offline to complete experience')
    end
    it "Custom Validation ensure if you are a mentor before you make an experience" do
      experience2 = Experience.new(api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id, available_offline: false, available_online: false)
      experience2.api_user.mentor = false
      expect(experience2).to be_invalid
      expect(experience2.errors.full_messages).to include('Api user if you are creating an experience you must be a mentor')
    end
  end

end
