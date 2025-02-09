class ModelCoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_model_course, only: [:show, :update, :destroy]

  # 🔹 モデルコース一覧
  def index
    @model_courses = ModelCourse.includes(:application_user).order(created_at: :desc)

    respond_to do |format|
      format.html { render :index }  # ← ビューを表示
      format.json { render json: @model_courses } # JSON も返せる
    end
  end

  # 🔹 モデルコースの詳細
  def show
    respond_to do |format|
      format.html { render :show }  # ビューを表示
      format.json { render json: @model_course }
    end
  end

  # 🔹 モデルコースの作成
  def create
    @model_course = current_user.model_courses.new(model_course_params)

    if @model_course.save
      handle_image_attachments(@model_course, params)
      redirect_to model_courses_path, notice: "モデルコースが作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 🔹 モデルコースの更新
  def update
    if @model_course.update(model_course_params)
      handle_image_attachments(@model_course, params)
      redirect_to model_course_path(@model_course), notice: "モデルコースが更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 🔹 モデルコースの削除
  def destroy
    @model_course.destroy
    redirect_to model_courses_path, notice: "モデルコースが削除されました"
  end

  private

  def set_model_course
    @model_course = ModelCourse.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to model_courses_path, alert: "モデルコースが見つかりません"
  end

  def model_course_params
    params.require(:model_course).permit(:title, :description, :budget, :season, :genre_tags)
  end

  def handle_image_attachments(model_course, params)
    if params[:model_course][:theme_image].present?
      model_course.theme_image.attach(params[:model_course][:theme_image])
    end

    if params[:model_course][:gallery_images].present?
      gallery_images = [params[:model_course][:gallery_images]].flatten
      gallery_images.each { |image| model_course.gallery_images.attach(image) if image.is_a?(ActionDispatch::Http::UploadedFile) }
    end
  end
end
