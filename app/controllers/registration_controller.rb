class RegistrationController < ApplicationController
  def new
    @user = ApplicationUser.new
    render :signup
  end

  def create
    @user = ApplicationUser.new(signup_user_params.merge(role: 'user'))
    # デフォルトでアカウントタイプを個人（individual）に設定
    @user.account_type ||= 'individual'
    # アカウントタイプが個人の場合、corporate_type をクリア
    @user.corporate_type = nil if @user.account_type == 'individual'
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to complete_registration_path
    else
      Rails.logger.error @user.errors.full_messages
      flash.now[:alert] = 'サインアップに失敗しました'
      render :signup, status: :unprocessable_entity
    end
  end

  def complete
    render :complete
  end

  private

  def signup_user_params
    params.require(:signup_user).permit(
      :user_id, :username, :email, :password, :password_confirmation,
      :account_type, :corporate_type
    )
  end
end
