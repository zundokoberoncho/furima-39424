class AddSoldOutToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :sold_out, :boolean, default: false
  end
end