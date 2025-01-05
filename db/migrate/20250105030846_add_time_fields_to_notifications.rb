class AddTimeFieldsToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :hour, :integer, null: false
    add_column :notifications, :minute, :integer, null: false
    add_column :notifications, :ampm, :string, null: false
  end
end

