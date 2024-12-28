class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :days_of_week, null: false, default: ""
      t.time :time, null: false    

      t.timestamps
    end
  end
end
