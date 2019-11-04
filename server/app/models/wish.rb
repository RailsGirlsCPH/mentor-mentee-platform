class Wish < ApplicationRecord
  belongs_to :api_user
  # validation
  validates_presence_of :goal
end
