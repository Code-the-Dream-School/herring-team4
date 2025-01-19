class CreateNoticedEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :noticed_events do |t|
      t.references :notifiable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false
      t.datetime :read_at

      t.timestamps
    end

    add_index :noticed_events, :user_id
    add_index :noticed_events, :notifiable_id
  end
end
