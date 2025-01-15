class ReviewsController < ApplicationController
  before_action :set_spot, only: %i[index new create show destroy] # destroyを追加
  before_action :set_review, only: %i[show destroy] # destroyを追加
  before_action :ensure_review_owner, only: [:destroy]

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

  def destroy
    # トランザクションを使用して、レビューと関連する画像の削除を保証
    ActiveRecord::Base.transaction do
      # Active Storageの画像を明示的に削除
      @review.images.purge if @review.images.attached?
      @review.destroy!
    end

    # 削除後はスポットの詳細ページにリダイレクト
    redirect_to spot_path(@spot), notice: 'レビューを削除しました'
  rescue StandardError => e
    # エラーが発生した場合は元のページに戻る
    redirect_to spot_review_path(@spot, @review),
                alert: 'レビューの削除に失敗しました'
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

    redirect_to spot_path(@spot), alert: '他のユーザーのレビューは削除できません'
  end
end
