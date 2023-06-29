class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.order("created_at ASC").page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     redirect_to admin_customer_path(@customer), notice: "顧客情報を更新しました"
    else
     render :edit
    end
  end
  
  def order
     @customer = Customer.find(params[:id])
     @orders = @customer.orders.page(params[:page])
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postcode,:address,:phone_number,:email,:is_deleted)
  end
end