class ReviewsController < ApplicationController
  before_action :set_spot, only: %i[index new create show] # showも追加
  before_action :set_review, only: [:show]

  def index
    @reviews = @spot.reviews
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
      redirect_to spot_path(@spot), notice: 'レビューを投稿しました'
    else
      render :new, status: :unprocessable_entity
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
end
