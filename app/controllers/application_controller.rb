# 全コントローラーの基底クラス
# 認証関連の共通機能を提供する
class ApplicationController < ActionController::Base
  # 全アクションの実行前にログインチェックを実行
  before_action :require_sign_in

  private

  # @return [ApplicationUser, nil] 現在ログインしているユーザー
  # セッションに保存されたユーザーIDから、ログイン中のユーザーを取得
  # 未ログインの場合はnil
  def current_user
    @current_user ||= ApplicationUser.find_by(id: session[:user_id])
  end

  # ログインが必要なアクションに対する認証チェック
  # 未ログインの場合、ログインページにリダイレクト
  def require_sign_in
    return if current_user

    redirect_to sign_in_path, alert: 'ログインが必要です'
  end

  # @return [Boolean] ユーザーがログインしているかどうか
  def sign_in?
    current_user.present?
  end

  # current_userとsign_in?メソッドをビューでも使用可能にする
  helper_method :current_user, :sign_in?
end
