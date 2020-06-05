RSpec.describe Meetinginterval, type: :model do
  it {is_expected.to validate_presence_of(:interval) }
end
