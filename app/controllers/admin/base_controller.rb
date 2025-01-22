class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  private

  def authenticate_admin!
    return if current_user&.admin?

    redirect_to root_path
  end
end
