FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    sequence(:username) { |n| "user#{n}_#{Faker::Internet.username}" }
  end
end