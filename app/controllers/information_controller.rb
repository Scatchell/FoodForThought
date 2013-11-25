class InformationController < ApplicationController
  def users
    @users = User.all

    respond_to do |format|
      format.js  {render :json => @users.as_json}
    end
  end

  def items
    @items = Item.all

    respond_to do |format|
      format.js  {render :json => @items.as_json}
    end
  end

  def orders
    @orders = OrderHistory.all

    respond_to do |format|
      format.js {render :json => @orders.as_json}
    end
  end
end
