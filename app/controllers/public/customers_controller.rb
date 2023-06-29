class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end
  
  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    @customer.update(customer_params)
    redirect_to customers_information_path
    flash[:notice] = "変更が完了しました"
  end
  
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.find(params[:id])
    @customer.save

  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postcode, :address, :phone_number, :encrypted_password)
  end
end
