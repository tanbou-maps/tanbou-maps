class ReviewsController < ApplicationController
  before_action :set_spot, only: %i[index new create show destroy] # destroyを追加
  before_action :set_review, only: %i[show destroy] # destroyを追加
  before_action :ensure_review_owner, only: [:destroy]

  def index
    @reviews = @spot.reviews.includes(:application_user)

    respond_to do |format|
      format.html
      format.json do
        reviews_json = @reviews.map do |review|
          review_hash = review.as_json(include: {
                                         application_user: { only: %i[id name nickname] }
                                       })
          review_hash['image_urls'] = review.images.map do |image|
            Rails.application.routes.url_helpers.rails_blob_url(image, only_path: false)
          end
          review_hash
        end

        render json: {
          reviews: reviews_json,
          spot: @spot.as_json(include: :spot_detail)
        }
      end
    end
  end

  def show
    # @reviewはbefore_actionで設定済み
  end

  def new
    @review = @spot.reviews.build
  end

  def create
    @review = @spot.reviews.build(review_params)
    @review.application_user_id = current_user.id

    if @review.save
      # JSON形式でメッセージを返す
      respond_to do |format|
        format.html { redirect_to spot_path(@spot), notice: j(I18n.t('reviews.create.success')) }
        format.json { render json: { status: 'success', message: I18n.t('reviews.create.success') } }
      end
    else
      # エラーメッセージもJSON形式で返す
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { status: 'error', errors: @review.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @review.images.purge if @review.images.attached?
      @review.destroy!

      respond_to do |format|
        format.html { redirect_to spot_path(@spot), notice: j(I18n.t('reviews.destroy.success')) }
        format.json { render json: { status: 'success', message: I18n.t('reviews.destroy.success') } }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { redirect_to spot_review_path(@spot, @review), alert: j(I18n.t('reviews.destroy.error')) }
      format.json { render json: { status: 'error', message: I18n.t('reviews.destroy.error') }, status: :unprocessable_entity }
    end
  end

  private

  def set_review
    @review = @spot.reviews.find(params[:id])
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :latitude, :longitude, images: []) # photosをimagesに変更
  end

  def ensure_review_owner
    return if @review.application_user_id == current_user.id

    respond_to do |format|
      format.html { redirect_to spot_path(@spot), alert: j(I18n.t('reviews.authorization.error')) }
      format.json { render json: { status: 'error', message: I18n.t('reviews.authorization.error') }, status: :forbidden }
    end
  end
end
