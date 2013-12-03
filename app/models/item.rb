class Item < ActiveRecord::Base
  validates_presence_of :item_type, :name, :price
  validates_numericality_of :price

  has_and_belongs_to_many :order

  extend ApplicationHelper

  def self.all_item_types
    Item.select(:item_type).map { |e| capitalize_first_letter(e.item_type) }.uniq
  end

  def downcase_item_type!
    item_type.downcase! unless item_type.nil?
  end

  def self.reset_all_to_unavailable
    @items = Item.all

    @items.each do |item|
      item.update_attributes(available: false)
    end
  end
end
