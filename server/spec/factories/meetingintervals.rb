FactoryBot.define do
  factory :meetinginterval do
    interval {Faker::Lorem.word} #Misc doesn't seem to work {Faker::Misc.password}
  end
end
