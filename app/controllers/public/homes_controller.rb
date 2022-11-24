class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @items=Item.page(params[:page]).order('id DESC').per(4)
  end

  def about
  end

end
