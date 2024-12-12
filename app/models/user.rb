class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :entries, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  def add_friend(other_user)
    friendships.create(friend: other_user)
    other_user.friendships.create(friend: self)
  end

  def remove_friend(other_user)
    friendships.find_by(friend: other_user).destroy
    other_user.friendships.find_by(friend: self).destroy
  end

  def check_streak()

    current_date = Date.current
    current_entry = 0
    streak = 0

    entry_dates = self.entries.select("DATE(created_at) AS unique_date").group("DATE(created_at)").order(created_at: :desc)

    # check if date of first entry is today, if so, add 1 to streak
    if Date.parse(entry_dates[current_entry].unique_date) == current_date
      current_entry = current_entry + 1
      streak = streak + 1
    end

    current_date = current_date - 1

    is_streak = true
    while is_streak
      if Date.parse(entry_dates[current_entry].unique_date) == current_date
        current_entry = current_entry + 1
        streak = streak + 1
        current_date = current_date - 1
      else
        is_streak = false
      end

    end

    puts streak

  end
end
