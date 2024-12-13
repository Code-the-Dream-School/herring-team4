FactoryBot.define do
  factory :entry do
    user
    text { Faker::Lorem.sentence }
    emotion { Faker::Emotion.noun }
    location { Faker::Address.city }
    people { Faker::Name.name }
    activity { Faker::Hobby.activity }
    energy_level { rand(1..10) }
  end
end