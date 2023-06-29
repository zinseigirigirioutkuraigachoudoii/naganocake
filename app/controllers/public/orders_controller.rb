class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    cart_items = current_customer.cart_items
    if cart_items.present?
      @order = Order.new
      @address = ShippingAddress.all
    else
      flash[:notice] = "カートが空です"
      redirect_to request.referer
    end
  end

  def confirm
    if params[:order]
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @cart_items = current_customer.cart_items
      @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      @order.postage = 800
      @order_total_amount = @total_amount + @order.postage.to_i

    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      
    if ShippingAddress.exists?(id: params[:order][:shipping_address_id])
      @address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.name = @address.name
      @order.post_code = @address.postcode
      @order.address = @address.address
    else
      flash[:notice] = "配送先情報がありません"
      render 'new'
    end
    elsif params[:order][:select_address] == "2"
      @order.name = params[:order][:name]
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
    else
      render 'new'
    end
      @address = "〒" + @order.post_code + @order.address
      session[:order] = @order.attributes
    end

    if session[:order]
      @order = Order.new(session[:order])
      @cart_items = current_customer.cart_items
      @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      @order.postage = 800
      @order_total_amount = @total_amount + @order.postage.to_i
      @address = "〒" + @order.post_code + @order.address
    else
      @order = Order.new
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
    @order.total = @total_amount + @order.postage.to_i

    if @order.save
      current_customer.cart_items.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.item_id = cart_item.item_id
        @order_item.order_id = @order.id
        @order_item.price = cart_item.item_with_tax_price
        @order_item.quantity = cart_item.quantity
        @order_item.status = 0
        @order_item.save
      end
      current_customer.cart_items.destroy_all
      redirect_to thanx_orders_path
    else
      flash[:notice] = "住所は必須です"
      @order = Order.new(order_params)
      render 'new'
    end
  end

  def thanx
  end

  def index
    @orders = current_customer.orders.all.page(params[:page]).per(5).order(created_at: :DESC)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_items = @order.order_items.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :total, :status, :payment, :name, :post_code, :address)
  end
  
  def shipping_address_params
    params.require(:shipping_address).permit(:postcode, :address, :name, :customer_id)
  end
end
