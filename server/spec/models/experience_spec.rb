require 'rails_helper'

RSpec.describe Experience, type: :model do
  let!(:api_user){
    create(:api_user, mentee: true)}
  let!(:prog){create(:programminglanguage)}
  let!(:meet){create(:meetinginterval)}

  describe 'validations' do
    subject {create(:experience, api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id)}
    it {should validate_presence_of(:qualification)}
    it {should validate_presence_of(:api_user_id)}
    it {should belong_to(:api_user)}
    it {should belong_to(:programminglanguage)}
    it {should belong_to(:meetinginterval)}
    it {should delegate_method(:language).to(:programminglanguage)}
    it {should delegate_method(:interval).to(:meetinginterval)}
    it "validations custom 1" do
      experience1 = Experience.new(api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id, available_offline: false, available_online: false)
      expect(experience1).to be_invalid
      expect(experience1.errors.full_messages).to include('Api user must be available either online or offline to complete experience')
    end
    it "validations custom 2" do
      experience2 = Experience.new(api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id, available_offline: false, available_online: false)
      experience2.api_user.mentor = false
      expect(experience2).to be_invalid
      expect(experience2.errors.full_messages).to include('Api user if you are creating an experience you must be a mentor')
    end
  end

end
