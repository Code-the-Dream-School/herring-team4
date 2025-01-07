class RemoveTimeFromNotifications < ActiveRecord::Migration[7.1]
  def change
    remove_column :notifications, :time, :time
  end
end
