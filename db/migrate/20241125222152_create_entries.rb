class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :text
      t.string :emotion
      t.string :location
      t.string :people
      t.string :activity
      t.integer :energy_level

      t.timestamps
    end
  end
end
