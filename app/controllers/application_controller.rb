class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
end

private

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
  devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password, :password_confirmation, :email, :remember_me])
  devise_parameter_sanitizer.permit(:edit, keys: [:username, :email, :password, :password_confirmation, :introduction, :avatar])
end
