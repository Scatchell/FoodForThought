class CreateOrderItemsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :orders, :items do |t|
      t.index [:item_id, :order_id], unique: true
    end
  end
end
