class OrderController < ApplicationController

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new params.require(:order).permit(:name)

    @order.save

    redirect_to @order
  end
end
