class RenameInfoToDescriptionInItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :description, :description
  end
end