class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_url

  def after_sign_in_path_for(resource)
    customers_my_page_path
  end

  def after_sign_up_path_for(resource)
    customers_my_page_path
  end

  protected

  def admin_url
    request.fullpath.include?("/admin")
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :phone_number])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email])
  end

end