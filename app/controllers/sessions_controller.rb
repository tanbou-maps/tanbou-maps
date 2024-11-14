# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    # サインアップページ
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # サインイン成功時のリダイレクトやその他の処理
    else
      # サインイン失敗時の処理
    end
  end

  def destroy
    session.delete(:user_id)
    # サインアウト成功時のリダイレクトやその他の処理
  end
end
