class RegistrationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    render :signup
  end

  def create
    data = signup_user_params # data変数を定義

    signup_user = ApplicationUser.new(
      name: data[:name],
      nickname: data[:nickname],
      email: data[:email],
      password_digest: data[:password_digest],
      account_type: data[:account_type],
      corporate_type: data[:corporate_type]
    )

    if signup_user.save
      render json: { message: 'Sign-up successful!' }, status: :ok
    else
      Rails.logger.error signup_user.errors.full_messages
      render json: { errors: signup_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def signup_user_params
    params.require(:signup_user).permit(:name, :nickname, :email, :password_digest, :account_type, :corporate_type)
  end
end
