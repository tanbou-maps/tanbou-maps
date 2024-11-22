class SessionsController < ApplicationController
  def new
    render :signin
  end

  def create
    user = ApplicationUser.find_by(user_id: params[:user_id]) || ApplicationUser.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインに成功しました'
    else
      flash.now[:alert] = 'ユーザー名またはパスワードが正しくありません'
      render :signin, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
