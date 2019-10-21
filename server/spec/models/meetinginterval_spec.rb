require 'rails_helper'

RSpec.describe Meetinginterval, type: :model do
  it { should validate_presence_of(:interval) }
end
