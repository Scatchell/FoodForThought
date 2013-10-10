class AddUserIdToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.belongs_to :user
    end

    change_table :order_histories do |t|
      t.belongs_to :user
    end
  end
end
