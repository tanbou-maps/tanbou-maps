class ReviewTestController < ApplicationController
  def index
    @post = ReviewTest.all # @posts変数にデータベース内の情報を全て入れる
    render :index
  end

  def show
    @post = ReviewTest.find(params[:id])
    render :show
  end

  def new
    @post = ReviewTest.new
    render :new
  end

  def edit
    @post = ReviewTest.find(params[:id])
    render :edit
  end

  def create
    @post = ReviewTest.new(review_test_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = ReviewTest.find(params[:id])

    if @post.update(review_test_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = ReviewTest.find(params[:id])
    @post.destroy

    render :delete
  end

  private

  def review_test_params
    params.require(:review_test).permit(:title, :memo)
  end
end
