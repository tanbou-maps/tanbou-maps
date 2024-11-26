class RegistrationController < ApplicationController
  # skip_before_action :verify_authenticity_token
  def new
    if logged_in?
      redirect_to root_path, notice: '現在サインイン中です'
    else
      @user = ApplicationUser.new
      render :signup
    end
  end

  def create
    @user = ApplicationUser.new(signup_user_params.merge(role: 'user'))
    # デフォルトでアカウントタイプを個人（individual）に設定
    @user.account_type ||= 'individual'
    # アカウントタイプが個人の場合、corporate_type をクリア
    @user.corporate_type = nil if @user.account_type == 'individual'

    if @user.save
      render json: { message: "Registration successful!", redirect_url: complete_registration_path }, status: :created
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

  def logged_in?
    session[:user_id].present?
  end

  def signup_user_params
    params.require(:signup_user).permit(
      :user_id, :nickname, :email, :password, :password_confirmation,
      :account_type, :corporate_type
    )
  end
end
