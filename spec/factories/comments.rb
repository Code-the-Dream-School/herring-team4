FactoryBot.define do
  factory :comment do
    user
    entry
    text { Faker::Lorem.sentence }
  end
end