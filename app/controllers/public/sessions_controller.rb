# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]

  # GET /resource/sign_in
def new
  
end

  # POST /resource/sign_in
def create
  
end

  # DELETE /resource/sign_out
def destroy
  
end

  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password])
    end
  end
end
