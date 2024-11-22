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
      formatted_errors = signup_user.errors.messages.map do |field, messages|
        { field: field.to_s, messages: messages.map { |msg| "#{field.to_s.humanize} #{msg}" } }
      end
      render json: { errors: formatted_errors }, status: :unprocessable_entity
    end
  end

  private

  def signup_user_params
    params.require(:signup_user).permit(:name, :nickname, :email, :password_digest, :account_type, :corporate_type)
  end
end
