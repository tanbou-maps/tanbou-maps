class SessionsController < ApplicationController
  skip_before_action :require_sign_in, only: %i[new create]

  def new
    render :signin
  end

  def create
    user = ApplicationUser.find_by(user_id: params[:user_id]) || ApplicationUser.find_by(email: params[:user_id])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { success: true, redirect_url: root_path }, status: :ok
    else
      render json: { success: false, error: 'ユーザー名またはパスワードが正しくありません' }, status: :unprocessable_entity
    end
  end

  def signout
    render :signout
  end

  def destroy_session
    # セッションを削除
    session[:user_id] = nil
  end
end
