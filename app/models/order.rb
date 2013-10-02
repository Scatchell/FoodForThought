class Order < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :items

  def available_items
    items.to_a.select do |item|
      item.available?
    end
  end

  def total_price
    items.to_a.map { |item| item.price }.max
  end

  def items_string
    item_names.join(' + ')
  end

  private
  def item_names
    items.map { |item| item.name }
  end
end
