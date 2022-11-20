class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
  end

  def show
    #@item = Item.find(params[:id])
  end

end
