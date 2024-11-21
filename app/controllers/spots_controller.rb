class SpotsController < ApplicationController
  def search
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def index
    @spots = Spot.all.includes(:images)
    render json: @spots.as_json(include: { images: { only: %i[id url] } })
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

      render json: @spot, status: :created
    else
      render json: { message: @spot.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :description, :latitude, :longitude)
  end
end
