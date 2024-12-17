FactoryBot.define do
  factory :reaction do
    user
    entry
    emote { Faker::Emoji.emoticon }
  end
end