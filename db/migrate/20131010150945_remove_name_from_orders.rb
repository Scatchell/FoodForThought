class RemoveNameFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :name, :string
    remove_column :order_histories, :name, :string
  end
end
