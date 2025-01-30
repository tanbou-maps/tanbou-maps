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

    respond_to do |format|
      format.html
      format.json do
        render json: {
          spot: @spot.as_json(
            include: {
              spot_detail: {}, # includeオプションを正しく設定
              reviews: {
                include: {
                  application_user: { only: %i[id name] }
                }
              }
            }
          ),
          google_maps_api_key: @google_maps_api_key
        }
      end
    end
  end

  def index
    @spots = Spot.all
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
