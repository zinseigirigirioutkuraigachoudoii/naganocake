class Public::CustomersController < ApplicationController
  def show
    @customer = current.user
  end
  
  def edit
    @customer = current.user
  end
  
  def update
    
  end
  
  def unsubscribe
    
  end
  
  def withdraw
    
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postcode, :address, :phone_number, :encrypted_password)
  end
end
