class ItemsController < ApplicationController
  http_basic_authenticate_with name: "allinall", password: "twcollins"

  def new
    @item = Item.new
  end

  def create
    @item = Item.new params.require(:item).permit(:name, :price, :item_type)

    @item.available = false

    if @item.save
      flash[:notice] = 'Item successfully added!'
    else
      flash[:error] = 'Item failed to save, please try again'
    end

    redirect_to items_path
  end

  def show
    @item = Item.find params[:id]
  end

  def index
    @items = Item.order('price DESC')
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

    flash[:notice] = 'Items successfully updated!'

    redirect_to items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy

    flash[:notice] = 'Item has been successfully removed'

    redirect_to items_path
  end

end
