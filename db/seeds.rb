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
predefined_emotions = %w[Connected Calm Good Thoughtful Relaxed Sad Bored Tired Meh Disappointed Excited Pleased Happy Cheerful Upbeat Angry Anxious Peeved Tense Irate]
predefined_locations = %w[Home Library School Work Park Outside Gym Restaurant]
predefined_activities = %w[Cooking Eating Working\ out Cleaning Journaling Meditating Working Dancing Water\ Aerobics]
predefined_company = %w[Friends Family Pets Strangers Myself Colleagues]
default_image_path = Rails.root.join('spec', 'fixtures', 'files', 'default.png')

users << User.create!(
  username: "admin",
  email: "admin@admin.com",
  password: "password",
  password_confirmation: "password"
)
# create 10 other users
10.times do |i|
  users << User.create!(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.unique.username,
    password: "password",
    password_confirmation: "password"
  )
end

# add a default pic to each user
users.each do |user|

  avatar_url = "https://loremflickr.com/500/500"
  file = URI.open(avatar_url)

  user.profile_picture.attach(
    io: file,
    filename: "#{user.username}.jpg",
    content_type: 'image/png'
  )

  # user.profile_picture.attach(
  #   io: File.open(default_image_path),
  #   filename: 'default.png',
  #   content_type: 'image/png'
  # )
end

# make all users friends with user 1
first_user = users[0]
users[1..].each do |friend|
  Friendship.create!(user_id: first_user.id, friend_id: friend.id)
end

users.each do |user|
  3.times do
    user.entries.create!(
      text: Faker::Lorem.paragraph,
      emotion: predefined_emotions.sample,
      location: [predefined_locations.sample].to_json,
      company: predefined_company.sample(2).to_json,
      activity: predefined_activities.sample(2).to_json,
      is_public: true,
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

# other users add 1 comment to each post of admin
first_user_entries = first_user.entries
first_user_entries.each do |entry|
  users.each do |user|
    Comment.create!(
      entry_id: entry.id,
      user_id: user.id,
      text: 'this is a random comment'
    )
  end
end

entries = Entry.all
entries.each do |entry|
  users.each do |user|
    Comment.find_or_create_by!(
      entry: entry,
      user: user,
      text: Faker::Lorem.sentence(word_count: 10)
    )
  end
end


