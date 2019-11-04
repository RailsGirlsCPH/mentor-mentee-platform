FactoryBot.define do
  factory :wish do
    available_offline {Faker::Boolean.boolean(true_ratio: 0.5)}
    available_online {Faker::Boolean.boolean(true_ratio: 0.5)}
    goal {Faker::Lorem.sentence(word_count: 3)}
    api_user_id {Faker::Number.number(digits: 2)}
    programminglanguage_id {Faker::Number.number(digits: 2)} 
    meetinginterval_id {Faker::Number.number(digits: 2)}
  end
end
