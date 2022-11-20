class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.page(params[:page]).per(10)
    @items = Item.page(params[:page]).per(4)
  end

end

