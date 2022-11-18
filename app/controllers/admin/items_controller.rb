class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new
    @item.save
    redirect_to admin_items_path
  end

  def index
    @item = Item.new
    @items = Item.all.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end


  private
  def item_params
    params.require(:item).permit(:image, :name, :caption, :genre_id, :excluded_price, :is_status)
  end
end
