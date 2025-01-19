class AddTimeToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :time, :datetime
  end
end
