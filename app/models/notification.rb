class Notification < ApplicationRecord
  belongs_to :user

  validates :days_of_week, presence: true
  validates :hour, presence: true
  validates :minute, presence: true
  validates :ampm, presence: true

  # Save days_of_week as a comma separated string
  def days_of_week=(value)
    write_attribute(:days_of_week, value.to_a.join(","))
  end

  # Return days_of_week as an array
  def days_of_week
    read_attribute(:days_of_week).split(",") if read_attribute(:days_of_week)
  end

end
