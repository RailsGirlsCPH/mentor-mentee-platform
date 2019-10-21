FactoryBot.define do
  factory :wish do
    available_offline {Faker::Boolean.boolean(true_ratio: 0.5)}
    available_online {Faker::Boolean.boolean(true_ratio: 0.5)}
    goal {Faker::Lorem.sentence(word_count: 3)}
    api_user_id nil
    programminglanguage_id nil
    meetinginterval_id nil
  end
end
