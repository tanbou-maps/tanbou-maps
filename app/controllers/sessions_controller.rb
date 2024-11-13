# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    # 新規ログインページ
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # ログイン成功時のリダイレクトやその他の処理
    else
      # ログイン失敗時の処理
    end
  end

  def destroy
    session.delete(:user_id)
    # ログアウト成功時のリダイレクトやその他の処理
  end
end
