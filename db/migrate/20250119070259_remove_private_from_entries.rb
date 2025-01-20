class RemovePrivateFromEntries < ActiveRecord::Migration[7.1]
  def change
    remove_column :entries, :private, :boolean
  end
end
