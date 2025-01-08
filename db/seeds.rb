# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all

users = []

users << User.create!(
  username: "admin",
  email: "admin@example.com", password: "password", password_confirmation: "password")

# create 10 other users
10.times do |i|
  users << User.create!(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.unique.username,
    password: "password",
    password_confirmation: "password"
  )
end

# make all users friends with user 1
first_user = users[0]
users[1..].each do |friend|
  Friendship.create!(user_id: first_user.id, friend_id: friend.id)
end

users.each do |user|
  3.times do
    user.entries.create!(
      text: Faker::Lorem.sentence,
      emotion: "place holder emotion",
      location: Faker::Address.city,
      people: Faker::Name.name,
      activity: Faker::Hobby.activity,
      energy_level: rand(1..10),
      )
  end
end

# user1 adds reactions to each post
other_users_entries = Entry.where.not(user_id: first_user.id)
other_users_entries.each do |entry|
  Reaction.create!(
    entry_id: entry.id,
    user_id: first_user.id,
    emote: "love"
  )
end