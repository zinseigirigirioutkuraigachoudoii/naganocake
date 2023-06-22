class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:destroy]

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
  end

  def create
    increase_or_create(params[:cart_item][:item_id])
    redirect_to cart_items_path, notice: 'Successfully added item to your cart'
  end

  def destroy
    @cart_item.destroy
    redirect_to request.referer, notice: 'Successfully deleted one cart item'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
  
  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end
end