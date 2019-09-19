# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Note bug: when use admin to edit or make something will redirect to login_url
  before_action :require_login, only: %i[show edit update destroy]

  private

  def require_login
    if current_user.nil?
      flash[:danger] = 'Please login before'
      redirect_to login_url
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email,
               :password,
               :current_password,
               :name,
               :avatar)
    end
  end
end
