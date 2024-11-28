class IndexController < ApplicationController
  before_action :require_sign_in
  def show
  end

  def current_user
    @current_user ||= ApplicationUser.find_by(id: session[:user_id])
  end

  def require_sign_in
    return if current_user

    redirect_to sign_in_path, alert: 'ログインが必要です'
  end
end
