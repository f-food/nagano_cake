class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).reverse_order.per(8)
    @genres = Genre.all
    @items_count = Item.where(is_status: true).count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def search
    @items = Item.page(params[:page]).per(10).reverse_order
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @genre_items = @genre.items.page(params[:page]).per(8)
  end

end
