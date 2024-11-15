# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  # ログインフォームを表示するアクション
  def new
    # 通常はログインフォームが含まれるビューを表示します。
    # ここにロジックを追加する必要はありませんが、フォーム関連の初期化が必要な場合はここで行います。
    render :signin # ファイル名を参照している(この場合defがnewのためnew.html.erbを参照してしまう)その為、renderでsigninに変更する
  end

  # ログイン試行を処理するアクション
  def create
    # フォームから送信されたユーザー名を使用してユーザーを検索
    user = User.find_by(name: params[:name])
    console.log('test')
    # ユーザーが存在し、パスワードが正しい場合はセッションにユーザーIDを保存
    if user&.authenticate(params[:email])
      session[:user_id] = user.id
      # ユーザーが正常にログインした場合、root_pathにリダイレクト
      redirect_to root_path, notice: 'サインインに成功しました。'
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
