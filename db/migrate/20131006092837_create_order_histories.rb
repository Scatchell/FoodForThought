class CreateOrderHistories < ActiveRecord::Migration
  def change
    create_table :order_histories do |t|
      t.string :name

      t.timestamps
    end
  end
end
