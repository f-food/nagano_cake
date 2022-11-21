class Admin::OrderDetailsController < ApplicationController



def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      if @order_detail.making_status == "under_construction"
        @order.update(status: "production")
      elsif @order.order_details.all?{|order_detail|order_detail.making_status == "production_completed"}
        @order.update(status: "preparing_to_ship")
      end
      redirect_to admin_order_path(@order)
    else
      render "show"
    end
end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
