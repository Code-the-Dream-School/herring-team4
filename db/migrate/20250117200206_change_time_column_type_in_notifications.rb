class ChangeTimeColumnTypeInNotifications < ActiveRecord::Migration[7.1]
  def change
    change_column :notifications, :time, :time
  end
end
