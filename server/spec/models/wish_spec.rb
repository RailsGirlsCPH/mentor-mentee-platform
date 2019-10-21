require 'rails_helper'

RSpec.describe Wish, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:api_user) }

  # Validation test
  # ensure column name is present before saving
end
