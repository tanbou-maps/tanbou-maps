class SpotsController < ApplicationController
  before_action :require_sign_in, only: %i[new create]

  def new
    @spot = Spot.new
    @spot.build_spot_detail
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.application_user_id = current_user.id # セッションから紐づける

    if @spot.save
      redirect_to spot_path(@spot), notice: 'スポットが正常に作成されました。'
    else
      @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def spot_params
    params.require(:spot).permit(
      :name,
      :description,
      :latitude,
      :longitude,
      photos: [],
      spot_detail_attributes: %i[hours_of_operation access_info contact_info website_url recommended_season entry_fee]
    )
  end

  def current_user
    @current_user ||= ApplicationUser.find_by(id: session[:user_id])
  end

  def require_sign_in
    return if current_user

    redirect_to sign_in_path, alert: 'ログインが必要です'
  end
end
