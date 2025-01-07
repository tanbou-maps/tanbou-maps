# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  # app/controllers/spots_controller.rb に追加
  def view
    @spots = Spot.all
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end

  def create
    @spot = Spot.find(params[:spot_id])
    @review = @spot.reviews.build(review_params)
    @review.application_user_id = current_user.id

    if @review.save
      redirect_to spot_path(@spot), notice: 'レビューを投稿しました'
    else
      redirect_to spot_path(@spot), alert: 'レビューの投稿に失敗しました'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :latitude, :longitude, photos: [])
  end
end
