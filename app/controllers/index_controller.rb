class IndexController < ApplicationController
  before_action :require_sign_in
  def show
    @latest_spots = Spot.order(created_at: :desc).limit(4)
  end

end
