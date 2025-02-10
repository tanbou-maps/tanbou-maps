class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /profile/:id
  def show
    # ユーザーのプロフィール情報を取得
    @user = ApplicationUser.find(params[:id])
  end

  # GET /profile/:id/edit
  def edit
    # 編集フォームの表示ロジック
  end

  # PATCH/PUT /profile/:id
  def update
    if @user.update(user_params)
      redirect_to profile_path(@user), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /profile/:id
  def destroy
    begin
      @user.destroy
      respond_to do |format|
        format.html { redirect_to sign_in_path, notice: 'アカウントが削除されました' }
        format.json { head :no_content }
      end
    rescue => e
      respond_to do |format|
        format.html { redirect_to profile_path(@user), alert: 'アカウントの削除に失敗しました' }
        format.json { render json: { error: e.message }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = ApplicationUser.find(params[:id])
  end

  def user_params
    params.require(:application_user).permit(:nickname, :email, :avatar_image, :cover_image)
  end
end
