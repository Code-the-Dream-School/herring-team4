FactoryBot.define do
  factory :entry do
    user
    text { Faker::Lorem.paragraph }
    emotion { %w[Connected Calm Good Thoughtful Relaxed Sad Bored Tired Meh Disappointed Excited Pleased Happy Cheerful Upbeat Angry Anxious Peeved Tense Irate].sample }
    location { [%w[Home Library School Work Park Outside Gym Restaurant Club].sample].to_json }
    company { %w[Friends Family Pets Strangers Myself Colleagues].sample(2).to_json }
    activity { %w[Cooking Eating Working\ out Cleaning Journaling Meditating Working Dancing Water\ Aerobics].sample(1).to_json }
    energy_level { rand(1..10) }
  end
end