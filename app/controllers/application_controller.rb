# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login, only: %i[show edit update destroy]

  private

  def require_login
    if current_user.nil?
      flash[:danger] = 'Please login before'
      redirect_to login_url
    end
  end




end
