require 'rails_helper'

RSpec.describe Wish, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:api_user) }

  # Validation test
  it { should validate_presence_of(:goal) }


  it "both online and offline should not be false" do
    example_a = build(:wish, available_offline: false, available_online: false)
    expect(example_a).to_not_be_valid
 end
end
