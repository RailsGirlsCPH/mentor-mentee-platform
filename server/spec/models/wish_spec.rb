require 'rails_helper'

RSpec.describe Wish, type: :model do

  let!(:api_user){
    create(:api_user, mentee: true)}
  let!(:prog){create(:programminglanguage)}
  let!(:meet){create(:meetinginterval)}

  describe 'validations' do
    subject {create(:wish, api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id)}
    it {should validate_presence_of(:goal)}
    it {should validate_presence_of(:api_user_id)}
    it {should belong_to(:api_user)}
    it {should belong_to(:programminglanguage)}
    it {should belong_to(:meetinginterval)}
    it {should delegate_method(:language).to(:programminglanguage)}
    it {should delegate_method(:interval).to(:meetinginterval)}
    it "validations custom 1" do
      wish1 = Wish.new(api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id, available_offline: false, available_online: false)
      expect(wish1).to be_invalid
      expect(wish1.errors.full_messages).to include('Api user must be available either online or offline to complete wish')
    end
    it "validations custom 2" do
      wish2 = Wish.new(api_user_id: api_user.id, programminglanguage_id: prog.id, meetinginterval_id: meet.id, available_offline: false, available_online: false)
      wish2.api_user.mentee = false
      expect(wish2).to be_invalid
      expect(wish2.errors.full_messages).to include('Api user if you are creating a wish you must be a mentee')
    end
  end

end


