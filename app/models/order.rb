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
      not_extra_items = items.to_a.select { |item| item.item_type != 'extra' }
      if get_meat_items.length > 1
        get_meat_price + get_extra_price
      else
        not_extra_item_prices = not_extra_items.to_a.map { |item| item.price }.max
        not_extra_item_prices + get_extra_price if not_extra_item_prices
      end
    end
  end

  def items_string
    item_names.join(' + ')
  end

  def get_extra_price
    extra_items = items.to_a.select { |item| item.item_type == 'extra' }
    extra_items.inject(0) { |total, item| total += item.price }
  end

  def get_meat_price
    meat_items = get_meat_items
    if meat_items.length == 1
      meat_items.first.price
    else
      meat_items.inject(0) { |total, item| total +=item.price } - 1000
    end
  end

  def get_meat_items
    items.to_a.select { |item| item.item_type == 'meat' }
  end

  def only_food?
    item_types.uniq == ['food']
  end

  private
  def item_names
    items.map { |item| item.name }
  end

  def item_types
    items.map { |item| item.item_type }
  end

end
