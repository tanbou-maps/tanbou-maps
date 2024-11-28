class SpotsController < ApplicationController
  def new
    @user = session[:user_id] # session情報を取り出す
    @spot = Spot.new
    @spot.build_spot_detail
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def create
    @spot = Spot.new(spot_params)

    if @spot.save
      redirect_to spot_path(@spot), notice: 'スポットが正常に作成されました。'
    else
      @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def search
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
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
end
