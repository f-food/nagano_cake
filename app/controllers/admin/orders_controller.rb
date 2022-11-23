class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) { |sum, item| sum + item.inclusive_price * item.quantity }
    @shipping_cost = 800
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if  @order.update(order_params)
      if @order.status == "waiting_for_payment"
        @order_details.update(making_status: "production_not_allowed")
      elsif @order.status == "payment_confirmation"
        @order_items.update(making_status: "waiting_for_production")
      end
      redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
