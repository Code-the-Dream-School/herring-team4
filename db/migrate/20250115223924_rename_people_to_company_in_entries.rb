class RenamePeopleToCompanyInEntries < ActiveRecord::Migration[7.1]
  def change
    rename_column :entries, :people, :company
  end
end
