# app/controllers/reviews_controller.rb
class ReviewController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_spot, only: %i[new create]

  def index
    @reviews = Review.includes(:application_user, :spot).order(created_at: :desc)
    render :index
  end

  def show
    @review = Review.find(params[:id])
    render :show
  end

  def new
    @review = Review.new
    render :new
  end

  def create
    @review = Review.new(review_params)
    @review.application_user_id = current_user.id
    @review.spot_id = @spot.id

    if @review.save
      flash[:notice] = "レビューを登録しました"
      redirect_to spot_reviews_path(@spot)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating, images: [])
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end
end
