class MigrateItemTypesForExistingItems < ActiveRecord::Migration
  def change
    #>= 5000 = meats
    Item.where('price >= 5000').each do |item|
      item.update_attribute(:item_type, 'meat')
      puts "Updated item: #{item.name} with item_type 'meat'"
    end
    # 4000 - 2000 inclusive = vegetable
    Item.where('price <= 4000 AND price >=2000').each do |item|
      item.update_attribute(:item_type, 'vegetable')
      puts "Updated item: #{item.name} with item_type 'vegetable'"
    end
    # 1000 - 500 inclusive = extra
    Item.where('price <= 1000 AND price >=500').each do |item|
      item.update_attribute(:item_type, 'extra')
      puts "Updated item: #{item.name} with item_type 'extra'"
    end
    # 0 = food
    Item.where('price = 0').each do |item|
      item.update_attribute(:item_type, 'food')
      puts "Updated item: #{item.name} with item_type 'food'"
    end
  end
end
