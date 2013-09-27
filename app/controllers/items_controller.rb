class ItemsController < ApplicationController
  def new
    #form
  end

  def create
    @item = Item.new params.require(:item).permit(:name, :price)

    @item.available = false

    @item.save

    redirect_to @item
  end

  def show
    @item = Item.find params[:id]
  end

  def index
    @items = Item.all
  end

  def mark_availability
    items = Item.all

    items.each do |item|
      item.update_attribute(:available, false)
    end

    if params[:items]
      items = Item.find(params[:items])

      items.each do |item|
        item.update_attribute(:available, true)
      end
    end

    redirect_to items_path
  end

end
