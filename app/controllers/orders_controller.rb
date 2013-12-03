class OrdersController < ApplicationController
  include ApplicationHelper

  before_filter :authenticate_user!
  #http_basic_authenticate_with name: "allinall", password: "twcollins", only: [:display_all, :destroy_all]

  def new
    @order = Order.where(user_id: current_user.id).first

    if @order
      redirect_to @order
    else
      @order = Order.new
    end

    @items_by_type = Item.where(available: true).order('price DESC').group_by { |e| e.item_type.to_sym }

    respond_to do |format|
      format.js {}
      format.html {}
    end

  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new

    @order.user = current_user

    respond_to do |format|
      format.html do
        if params[:items].nil?
          flash[:error] ||= []
          flash[:error] << 'Order not saved - must select at least a single item'
          redirect_to new_order_path
        else
          @items = Item.find(params[:items])
          @order.items = @items

          if @order.save
            session[:auth] = @order.id
            redirect_to @order
          else
            flash[:error] ||= []
            @order.errors.each do |error, msg|
              flash[:error] << capitalize_first_letter(error.to_s) + ' ' + msg
            end
            redirect_to new_order_path
          end
        end
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])

    if session[:auth] == @order.id
      @order.destroy
    else
      flash[:error] ||= []
      flash[:error] << 'You may not delete this order'
    end

    redirect_to new_order_path
  end

  def display_all
    @orders = Order.all
    @total_price_of_orders = total_price_of_all_orders
  end

  def destroy_all
    Order.destroy_all

    Item.reset_all_to_unavailable
    flash[:notice] ||= []
    flash[:notice] << 'All orders have been removed! Select the items below that you would like to be available on the next day'

    redirect_to items_path
  end

  private

  def total_price_of_all_orders
    @orders.inject(0) { |total, order| total += order.total_price unless order.items.empty? }
  end

end
