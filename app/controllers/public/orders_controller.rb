class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @addresses = current_customer.addresses.all
  end

  def create
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items.all
    @shipping_address = current_customer.addresses.new(address_params)
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = @order.order_details.new #注文詳細の作成
        @order_detail.item_id = cart_item.item_id #商品idの格納
        @order_detail.quantity = cart_item.quantity #商品の個数の格納
        @order_detail.inclusive_price = (cart_item.item.excluded_price * 1.10).floor #価格の格納
        @order_detail.save #注文詳細の保存。
      end
      if params[:order][:address_number] == "3"
        @shipping_address.save
      end
      @cart_items.destroy_all
      redirect_to complete_orders_path
    else
      #render :new
    end
  end

  def check
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_number] == "2"
      if params[:order][:customer_id] == ""
        redirect_to new_order_path
      else
        ship = Address.find(params[:order][:customer_id])
        @order.post_code = ship.post_code
        @order.address = ship.address
        @order.name = ship.attention_name
      end
    elsif params[:order][:address_number] == "3"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      if params[:order][:post_code] == "" || params[:order][:address] == "" || params[:order][:name] == ""
        redirect_to new_order_path
      end
    else
      redirect_to new_order_path
    end
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @cart_items.inject(800) { |sum, item| sum + item.subtotal }
    @shipping_cost = 800
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_payment, :shipping_cost, :status)
  end

  def address_params
    params.require(:order).permit(:attention_name, :address, :post_code, :customer_id)
  end

end
