class ChangeDaysOfWeekToArrayInNotifications < ActiveRecord::Migration[7.0]
  def change
    change_column :notifications, :days_of_week, :string, array: true, using: "string_to_array(days_of_week, ',')"
  end
end
