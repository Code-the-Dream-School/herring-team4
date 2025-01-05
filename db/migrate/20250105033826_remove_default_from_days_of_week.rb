class RemoveDefaultFromDaysOfWeek < ActiveRecord::Migration[7.0]
  def change
    change_column_default :notifications, :days_of_week, from: "", to: nil
  end
end
