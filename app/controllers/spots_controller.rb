class SpotsController < ApplicationController
  def new
    @spot = Spot.new
    @spot.build_spot_detail
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def create
    @spot = Spot.new(spot_params)

    if @spot.save
      # Handle image uploads
      if params[:spot][:images]
        params[:spot][:images].each do |image|
          @spot.images.create(file: image)
        end
      end

      redirect_to spots_path, notice: 'Spot was successfully created.'
    else
      render :new
    end
  end

  def index
    @spots = Spot.all.includes(:images)
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
