class ChangeDefaultForBioInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :bio, nil
  end
end