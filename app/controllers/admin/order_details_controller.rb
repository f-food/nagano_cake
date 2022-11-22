class Admin::OrderDetailsController < ApplicationController



def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)#(making_status: params[:order_detail][:making_status])
    if @order_detail.making_status == "making_now"
      @order.update(status: 2)
    elsif @order.order_details.count == @order.order_details.where(making_status: "making_comp").count
      @order.update(status: 3)
    end
    redirect_to admin_order_path(@order)
  end
  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
