FactoryBot.define do

  factory :wish do
    available_offline {Faker::Boolean.boolean(true_ratio: 1)}
    available_online {Faker::Boolean.boolean(true_ratio: 1)}
    # it is invalid for available_offline and available_online to both be set to false.
    # therefore when generating test data for spec one value is always set to true.
    # behaviour is tested further in wishes_spec.rb
    goal {Faker::Lorem.sentence(word_count: 3)}
    api_user_id {Faker::Number.number(digits: 2)}
    programminglanguage_id {Faker::Number.number(digits: 2)} 
    meetinginterval_id {Faker::Number.number(digits: 2)}
  end
end
