class Notification < ApplicationRecord
  belongs_to :user

  validates :days_of_week, presence: true
  validates :hour, presence: true
  validates :minute, presence: true
  validates :ampm, presence: true

end
