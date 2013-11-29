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

    orders_json = @orders.as_json.each do |order_json|
      order_json['items'] = OrderHistory.where(id: order_json['id']).first.items.to_a
    end

    respond_to do |format|
      format.js {render :json => orders_json}
    end
  end
end
