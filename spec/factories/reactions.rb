FactoryBot.define do
  factory :reaction do
    entry
    emote { Faker::Emoji.emoticon }
  end
end