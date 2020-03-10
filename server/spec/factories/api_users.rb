FactoryBot.define do
  factory :api_user do
    email {Faker::Internet.safe_email}
    password {Faker::Lorem.word} #Misc doesn't seem to work {Faker::Misc.password}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    username {Faker::Name.name}
    city {Faker::Address.city}
    mentor {Faker::Boolean.boolean(true_ratio: 1)}
    mentee {Faker::Boolean.boolean(true_ratio: 1)}
  end
end

