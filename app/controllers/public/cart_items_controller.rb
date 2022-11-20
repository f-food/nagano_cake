class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.item_id = params[:cart_item][:item_id]
    current_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    #カートに追加した商品が既にカート内に存在する場合
    if current_cart_item.present?
      current_cart_item.quantity += params[:cart_item][:quantity].to_i
      current_cart_item.save
      redirect_to cart_items_path
    #カートに追加した商品が既にカート内に存在しない場合
    else
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal } #合計金額を算出
  end

  def update
    cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    cart_item.quantity = params[:cart_item][:quantity].to_i
    cart_item.save
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end

end
