class AddTimezoneToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :timezone, :string
  end
end
