class SpotsController < ApplicationController
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

  def show
    @spot = Spot.find(params[:id])
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def index
    @spots = Spot.all
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def search
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def reviews
    @spot = Spot.find(params[:id])
    @reviews = @spot.reviews # アソシエーションを想定
  end

  def create_review
    @spot = Spot.find(params[:id])
    @review = @spot.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
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

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
