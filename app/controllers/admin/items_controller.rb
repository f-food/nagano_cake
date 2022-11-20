class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path(@item.id)
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end


#投稿データのストロングパラメータ
  private
  def item_params
    params.require(:item).permit(:image, :name, :caption, :genre_id, :excluded_price, :is_status)
  end

end
