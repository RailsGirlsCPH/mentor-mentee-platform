class ApplicationController < ActionController::API
  # include ActionController::ImplicitRender
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery unless: -> { request.format.json? }
  # acts_as_token_authentication_handler_for ApiUser, fallback: :none

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:username, :password, :password_confirmation, :mentor, :mentee ]) 
  # end
  private
  def set_api_user
    @api_user = current_api_user
  end
end


