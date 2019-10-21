FactoryBot.define do
  factory :programminglanguage do
    language {Faker::Lorem.word} #Misc doesn't seem to work {Faker::Misc.password}
  end
end
