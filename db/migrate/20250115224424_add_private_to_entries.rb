class AddPrivateToEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :private, :boolean, default: false
  end
end
