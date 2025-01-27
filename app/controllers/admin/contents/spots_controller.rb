# class Admin::Contents::SpotsController < Admin::BaseController
#   before_action :set_spot, only: %i[edit update destroy]

#   # すべてのspotが表示される
#   def index
#     @spots = Spot.all.order(created_at: :desc)
#   end

#   def new
#     @spot = Spot.new
#   end

#   def edit
#   end

#   def create
#     @spot = Spot.new(spot_params)
#     if @spot.save
#       redirect_to admin_contents_spots_path, notice: 'スポットが追加されました。'
#     else
#       render :new, alert: 'スポットの追加が失敗しました。もう一度やり直してください。'
#     end
#   end

#   def update
#     if @spot.update(spot_params)
#       redirect_to admin_contents_spots_path, notice: 'スポットが更新されました。'
#     else
#       render :edit, alert: 'スポットの更新が失敗しました。もう一度やり直してください。'
#     end
#   end

#   def destroy
#     @spot.destroy
#     redirect_to admin_contents_spots_path, notice: 'スポットが削除されました。'
#   end

#   private

#   def set_spot
#     @spot = Spot.find(params[:id])
#   end

#   def spot_params
#     permitted = params.require(:spot).permit(:name, :description, :latitude, :longitude, :popularity_score)
#     if permitted[:latitude].present? && permitted[:longitude].present?
#       factory = RGeo::Geographic.spherical_factory(srid: 4326) # 设置 SRID 为 4326
#       permitted[:location] = factory.point(permitted[:longitude].to_f, permitted[:latitude].to_f)
#     end
#     permitted.except(:latitude, :longitude)
#   end
# end

class Admin::Contents::SpotsController < Admin::BaseController
  before_action :set_spot, only: %i[edit update destroy show]
  before_action :set_google_maps_api_key

  def index
    @spots = Spot.all.order(created_at: :desc)
  end

  def show; end

  def new
    @spot = Spot.new
    @spot.build_spot_detail
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.application_user_id = current_user.id

    if @spot.save
      redirect_to admin_contents_spot_path(@spot), notice: 'スポットが正常に作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @spot.update(spot_params)
      redirect_to admin_contents_spot_path(@spot), notice: 'スポットが更新されました。'
    else
      render :edit, alert: 'スポットの更新が失敗しました。もう一度やり直してください。'
    end
  end

  def destroy
    @spot.destroy
    redirect_to admin_contents_spots_path, notice: 'スポットが削除されました。'
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def set_google_maps_api_key
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

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
