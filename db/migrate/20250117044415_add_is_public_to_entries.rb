class AddIsPublicToEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :is_public, :boolean
  end
end
