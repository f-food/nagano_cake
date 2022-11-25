class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
    render :show
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
   @customer = current_customer
   @customer.update_columns(is_deleted: true)
   if @customer.is_deleted == true
      sign_out current_customer
   end
    redirect_to root_path
  end

  def unsubscribe
    @customer = current_customer
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:post_code,:phone_number,:address,:email)
  end
end
