FactoryBot.define do
  factory :user do
    username { "test" }
    email { Faker::Internet.email }
    password { 'password' }
  end
end