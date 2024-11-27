class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.references :entry, null: false, foreign_key: true
      t.text :emote

      t.timestamps
    end
  end
end
