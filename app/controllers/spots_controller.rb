class SpotsController < ApplicationController
  def new
    @spot = Spot.new
    @spot.build_spot_detail
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def create
    @spot = Spot.new(spot_params)

    if @spot.save
      # Handle multiple photo attachments
      if params[:spot][:photos].present?
        params[:spot][:photos].each do |photo|
          @spot.photos.attach(photo)
        end
      end

      redirect_to @spot, notice: 'スポットが正常に作成されました。'
    else
      @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spot = Spot.with_attached_photos.find(params[:id])
  end

  private

  def spot_params
    params.require(:spot).permit(
      :name,
      :description,
      :latitude,
      :longitude,
      photos: [],
      spot_detail_attributes: %i[
        hours_of_operation
        access_info
        contact_info
        website_url
        recommended_season
        entry_fee
      ]
    )
  end
end
