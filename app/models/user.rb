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
  
  def add_friend(other_user)
    friendships.create(friend: other_user)
    other_user.friendships.create(friend: self)
  end

  def remove_friend(other_user)
    friendships.find_by(friend: other_user).destroy
    other_user.friendships.find_by(friend: self).destroy
  end



end
