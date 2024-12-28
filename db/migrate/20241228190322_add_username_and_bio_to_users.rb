class AddUsernameAndBioToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :bio, :text
    add_index :users, :username, unique: true
  end
end
