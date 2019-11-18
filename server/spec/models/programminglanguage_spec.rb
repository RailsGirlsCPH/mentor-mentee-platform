require 'rails_helper'

RSpec.describe Programminglanguage, type: :model do
  it { should validate_presence_of(:language) }
end
