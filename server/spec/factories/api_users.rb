FactoryBot.define do
  factory :api_user do
    email {Faker::Internet.safe_email}
    password_digest {Faker::Lorem.word} #Misc doesn't seem to work {Faker::Misc.password}
  end
end
