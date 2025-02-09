class ProfileController < ApplicationController
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
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /profile/:id
  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Account was successfully deleted.'
  end

  private

  def set_user
    @user = ApplicationUser.find(params[:id])
  end

  def user_params
    params.require(:application_user).permit(:nickname, :email, :avatar_image, :cover_image)
  end
end
