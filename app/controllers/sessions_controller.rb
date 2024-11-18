# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  # ログインフォームを表示するアクション
  skip_before_action :verify_authenticity_token # CSRFトークンの確認をスキップ
  def new
    # 通常はログインフォームが含まれるビューを表示します。
    # ここにロジックを追加する必要はありませんが、フォーム関連の初期化が必要な場合はここで行います。
    render :signin # ファイル名を参照している(この場合defがnewのためnew.html.erbを参照してしまう)その為、renderでsigninに変更する
  end

  # ログイン試行を処理するアクション
  def create
    # フォームから送信されたユーザー名を使用してユーザーを検索
    data = JSON.parse(request.body.read)
    Rails.logger.info("username: #{data['username']}")
    Rails.logger.info("password: #{data['password']}")

    user = AppUser.where(name: data['username']).first
    Rails.logger.info(user)
    # ユーザーが存在し、パスワードが正しい場合はセッションにユーザーIDを保存
    Rails.logger.info("search_username: #{user.name}")
    Rails.logger.info("search_email: #{user.email}")
    if user.name == 'name' && user.email == 'test@test.com' # 後に変える必要あり
      session[:user_id] = user.id
      # ユーザーが正常にログインした場合、root_pathにリダイレクト
      redirect_to root_path, notice: 'サインインに成功しました。' and return
    else
      # ユーザー名またはパスワードが不正な場合、エラーメッセージを表示してログインフォームを再表示
      flash.now[:alert] = 'ユーザー名またはパスワードが正しくありません。'
      render :new
    end
  end

  # ログアウトを処理するアクション
  def destroy
    # セッションからユーザーIDを削除してユーザーのログイン情報をクリア
    session.delete(:user_id)
    # ログアウトが完了した後、root_pathにリダイレクトしてユーザーに通知
    redirect_to root_path, notice: 'サインアウトしました。'
  end
end
