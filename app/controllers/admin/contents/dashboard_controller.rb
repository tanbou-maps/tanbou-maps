class Admin::Contents::DashboardController < Admin::BaseController
  before_action :authenticate_admin!
  def index
  end
end
