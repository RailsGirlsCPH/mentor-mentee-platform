require 'rails_helper'

RSpec.describe Wish, type: :model do
  #Association test
  #ensure an item record belongs to a single todo record
  # let!(:api_user){create(:api_user)}
  # let!(:programminglanguage){create(:programminglanguage)}
  # let!(:meetinginterval){create(:meetinginterval)}
  # let!(:wish){create(:wish, api_user_id: api_user.id, programminglanguage_id: programminglanguage.id, meetinginterval_id: meetinginterval.id)}
  # subject {:wish}

    # Validation test

  it { should validate_presence_of(:goal) }
  it { should validate_presence_of(:api_user_id)}

  it { should belong_to(:api_user) }

 #  it "both online and offline should not be false" do
 #    example_a = build(:wish, available_offline: false, available_online: false)
 #    expect(example_a).to_not be_valid
 # end
end
