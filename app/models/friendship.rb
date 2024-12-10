class Friendship < ApplicationRecord

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # user can not be friends with themselves
  validates :friend_id, uniqueness: { scope: :user_id }
  validate :not_self

  private

  def not_self
    errors.add(:friend_id, "can't be user id") if user_id == friend_id
  end

end
