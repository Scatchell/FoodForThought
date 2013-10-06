class CreateOrderHistoryItemsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :order_histories, :items do |t|
      t.index [:item_id, :order_history_id], unique: true
    end
  end
end
