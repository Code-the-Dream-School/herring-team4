FactoryBot.define do
  factory :notification do
    user
    days_of_week { ["Monday", "Tuesday", "Wednesday"].sample(2) }
    hour { rand(1..12) }
    minute { [0, 15, 30, 45].sample }
    ampm { ["AM", "PM"].sample }
  end
end

