class ItemsController < ApplicationController
  include ApplicationHelper
  #http_basic_authenticate_with name: "allinall", password: "twcollins"

  def new
    @item = Item.new
    @possible_item_types = Item.all_item_types
  end

  def create
    @item = Item.new params.require(:item).permit(:name, :price, :item_type)

    @item.available = false

    @item.downcase_item_type!

    if @item.save
      flash[:notice] ||= []
      flash[:notice] << 'Item successfully added!'
    else
      flash[:error] ||= []
      @item.errors.each do |error, msg|
        flash[:error] << capitalize_first_letter(error.to_s) + ' ' + msg
      end
    end

    redirect_to items_path
  end

  def show
    @item = Item.find params[:id]
  end

  def index
    @items_by_type = Item.all.order('price DESC').group_by { |e| e.item_type.to_sym }
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

    flash[:notice] ||= []
    flash[:notice] << 'Items successfully updated!'

    redirect_to items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy

    flash[:notice] ||= []
    flash[:notice] << 'Item has been successfully removed'

    redirect_to items_path
  end
end
