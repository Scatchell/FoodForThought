class Order < ActiveRecord::Base
  has_and_belongs_to_many :items
  belongs_to :user

  def available_items
    items.to_a.select do |item|
      item.available?
    end
  end

  def total_price
    if !items.empty?
      not_extra_items = items.to_a.select { |item| item.item_type != 'extra' }
      not_extra_items.to_a.map { |item| item.price }.max + get_extra_price
    else
      0
    end
  end

  def items_string
    item_names.join(' + ')
  end

  def get_extra_price
    extra_items = items.to_a.select { |item| item.item_type == 'extra' }

    extra_items.inject(0) { |total, item| total += item.price }
  end

  private
  def item_names
    items.map { |item| item.name }
  end

end
