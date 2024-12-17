class AddUserToReactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :reactions, :user, null: false, foreign_key: true
  end
end
