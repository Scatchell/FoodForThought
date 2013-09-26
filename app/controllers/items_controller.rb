class ItemsController < ApplicationController
  def new

  end

  def create
    @item = Item.new params.require(:item).permit(:name, :price)

    @item.save

    redirect_to @item
  end

  def show
    @item = Item.find params[:id]
  end

  def index
    @items = Item.all
  end
end
