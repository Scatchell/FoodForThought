class Order < ActiveRecord::Base
  has_and_belongs_to_many :items
  belongs_to :user

  def available_items
    items.to_a.select do |item|
      item.available?
    end
  end

  def total_price
    if only_food?
      3000
    else
      if more_than_one_meat_item?
        get_meat_price + get_extra_price
      else
        map_non_extra_item_price = only_non_extra_items.to_a.map { |item| item.price }.max
        if map_non_extra_item_price
          map_non_extra_item_price + get_extra_price
        else
          get_extra_price
        end
      end
    end
  end

  def more_than_one_meat_item?
    all_meat_items.length > 1
  end

  def only_non_extra_items
    items.to_a.select { |item| item.item_type != 'extra' }
  end

  def items_string
    item_names.join(' + ')
  end

  def get_extra_price
    extra_items = items.to_a.select { |item| item.item_type == 'extra' }
    extra_items.inject(0) { |total, item| total += item.price }
  end

  def get_meat_price
    meat_items = all_meat_items
    if meat_items.length == 1
      meat_items.first.price
    else
      meat_items.inject(0) { |total, item| total +=item.price } - 1000
    end
  end

  def all_meat_items
    items.to_a.select { |item| item.item_type == 'meat' }
  end

  def only_food?
    item_types.uniq == ['food']
  end

  def self.destroy_all
    @orders = self.all
    @orders.each do |order|
      OrderHistory.create!({user: order.user, items: order.items})
      order.destroy
    end
  end

  private
  def item_names
    items.map { |item| item.name }
  end

  def item_types
    items.map { |item| item.item_type }
  end

end
