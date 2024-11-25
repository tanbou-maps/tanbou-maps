class IndexController < ApplicationController
  def show
    if logged_in?
      render :show
    else
      redirect_to sign_in_path, alert: 'サインインが必要です。'
    end
  end
end

def logged_in?
  session[:user_id].present?
end
