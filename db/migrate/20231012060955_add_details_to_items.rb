class AddDetailsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :category_id, :integer
    add_column :items, :sales_status_id, :integer
    add_column :items, :shipping_fee_status_id, :integer
    add_column :items, :prefecture_id, :integer
    add_column :items, :scheduled_delivery_status_id, :integer
  end
end
