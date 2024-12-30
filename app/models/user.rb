class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :entries, dependent: :destroy

  has_many :friendships, dependent: :destroy

  has_many :inverse_friendships, class_name: "Friendship",
           foreign_key: "friend_id",
           dependent: :destroy

  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :username, presence: true, uniqueness: true
  validates :bio, length: { maximum: 500 }

  def add_friend(other_user)
    friendships.create(friend: other_user)
    other_user.friendships.create(friend: self)
  end

  def remove_friend(other_user)
    friendships.find_by(friend: other_user).destroy
    other_user.friendships.find_by(friend: self).destroy
  end

  def calculate_streak

    current_date = Date.current
    streak = 0

    entry_dates = self.entries
                      .group("DATE(created_at)")
                      .order("DATE(created_at) DESC")
                      .pluck("DATE(created_at)")

    entry_dates.each do | entry_date |
      if Date.parse(entry_date) === current_date
        streak += 1
        current_date -= 1
      else
        break
      end
    end

    streak

  end
end
