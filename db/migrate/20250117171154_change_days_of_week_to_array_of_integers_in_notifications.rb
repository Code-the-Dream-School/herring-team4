class ChangeDaysOfWeekToArrayOfIntegersInNotifications < ActiveRecord::Migration[7.1]
  def change
    change_column :notifications, :days_of_week, :integer, array: true, using: "days_of_week::int[]"
  end
end
