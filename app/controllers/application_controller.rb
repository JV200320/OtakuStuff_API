class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :email, :image, :bio])
  end
end