class RegistrationController < ApplicationController
  skip_before_action :require_sign_in, only: %i[new create]

  def new
    @user = ApplicationUser.new
    render :sign_up
  end

  def create
    @user = ApplicationUser.new(sign_up_user_params.merge(role: 'user'))
    # デフォルトでアカウントタイプを個人（individual）に設定
    @user.account_type ||= 'individual'
    # アカウントタイプが個人の場合、corporate_type をクリア
    @user.corporate_type = nil if @user.account_type == 'individual'

    if @user.save
      redirect_to sign_up_complete_path
    else
      formatted_errors = @user.errors.messages.map do |field, messages|
        { field: field.to_s, messages: messages }
      end
      render json: { errors: formatted_errors }, status: :unprocessable_entity
    end

    Rails.logger.debug { "Received params: #{params.inspect}" }
    Rails.logger.debug { "Validation errors: #{@user.errors.full_messages}" }
  end

  def complete
    render :complete
  end

  private

  def sign_up_user_params
    params.require(:sign_up_user).permit(
      :user_id, :nickname, :email, :password, :password_confirmation,
      :account_type, :corporate_type
    )
  end
end
