class Admin::Contents::SpotsController < Admin::BaseController
  before_action :set_spot, only: %i[edit update destroy show]
  before_action :set_google_maps_api_key
  skip_before_action :verify_authenticity_token, only: [:delete_photo]


  def index
    @spots = Spot.all.order(created_at: :desc)
  end

  def show; end

  def new
    @spot = Spot.new
    @spot.build_spot_detail
  end

  def edit
    @spot = Spot.find(params[:id])
    @spot.build_spot_detail unless @spot.spot_detail
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
    params[:spot].delete(:photos) if params[:spot][:photos].blank?
    if @spot.update(spot_params)
      redirect_to admin_contents_spot_path(@spot), notice: 'スポットが更新されました。'
    else
      render :edit, alert: 'スポットの更新が失敗しました。もう一度やり直してください。'
    end
  end

  # def delete_photo
  #   photo = ActiveStorage::Blob.find_signed(params[:id])
  #   if photo
  #     photo.purge
  #     redirect_to edit_admin_contents_spot_path(params[:id]), notice: '画像が削除されました。'
  #   else
  #     redirect_to edit_admin_contents_spot_path(params[:id]), alert: '画像の削除に失敗しました。'
  #   end
  # end

  def destroy
    ActiveRecord::Base.transaction do
      @spot.photos.purge if @spot.photos.attached?
      @spot.destroy
      redirect_to admin_contents_spots_path, notice: 'スポットが削除されました。'
    end
  rescue StandardError => e
    redirect_to admin_contents_spots_path, alert: 'スポットの削除に失敗しました。'
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
