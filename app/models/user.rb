class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :entries, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

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



end
