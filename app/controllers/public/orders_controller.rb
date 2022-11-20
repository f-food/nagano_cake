class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @address = current_customer.addresses.all
  end

  def create
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items.all
    @address = current_customer.addresses.new(address_params)
    if @order.save
      @cart_items.each do |cart_item|
        @order_details = @order.order_details.new
        @order_details.item_id = cart_item.item_id
        @order_details.quantity = cart_item.quantity
        @order_details.inclusive_price = (cart_item.item.excluded_price * 1.08).floor
        @order_details.save
      end
      if params[:order][:address_number] == "3" #新しいお届け先の場合
        @address.save
      end
      @cart_items.destroy_all
      redirect_to items_path #後で購入完了画面に変更
    else
      render :new
    end
  end

  def check
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1" #会員情報に登録している住所の場合
      @order.name = current_customer.full_name
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
    elsif params[:order][:address_number]  == "2" #登録している配送先を選択した場合
      if params[:order][:customer_id] == ""
        redirect_to new_order_path
      else
        send = Address.find(params[:order][:customer_id])
        @order.post_code = send.post_code
        @order.address = send.address
        @order.name = send.attention_name
      end
    elsif params[:order][:address_number] == "3" #新しく配送先を登録する場合
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      if params[:order][:post_code] == "" || params[:order][:address] == "" || params[:order][:name] == "" #フォームに入力されなかった場合
        redirect_to new_order_path
      end
    else
      redirect_to new_order_path
    end
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
    @order.total_payment = @cart_items.inject(800) { |sum, item| sum + item.subtotal}
    @shipping_cost = 800
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_payment, :shipping_cost)
  end

  def address_params
    params.require(:order).permit(:attention_name, :address, :post_code, :customer_id)
  end

end
