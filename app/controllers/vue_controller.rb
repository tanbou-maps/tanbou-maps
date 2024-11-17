class VueController < ApplicationController
  def index
    @vues = AppUser.all
  end

  # AppUser.newで新しいオブジェクトの作成
  # AppUser.newをインスタンス変数@vueに格納
  def sign_up
    @vue = AppUser.new
  end

  # インスタンス変数@vueにvue_paramsで許可されたデータを格納
  def create
    @vue = AppUser.new(vue_params)

    # データベースに保存された場合、@vueの詳細ページであるshow.html.erbに遷移する
    # 保存に失敗した場合、もう一度sign_upページに遷移する
    if @vue.save
      redirect_to vue_path(@vue)
    else
      render 'sign_up'
    end
  end

  # sign_upから送信されてきたデータのIDを取得して、そのIDのデータの詳細を表示する。
  def show
    @vue = AppUser.find(params[:id])
  end

  # privateから先のデータをここ以外で使えなくする

  private

  # app_userキーを持つデータのみを取得
  # permitで各パラメータの許可
  def vue_params
    params.require(:app_user).permit(:name, :email, :password, :account_type, :corporate_type)
  end
end
