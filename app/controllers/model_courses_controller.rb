class ModelCoursesController < ApplicationController
  before_action :set_model_course, only: [:show, :update, :destroy]

  # 🔹 モデルコース一覧
  def index
    @model_courses = ModelCourse.includes(:application_user).order(created_at: :desc)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @model_courses }
    end
  end

  # 🔹 モデルコースの詳細
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @model_course }
    end
  end

  # 🔹 モデルコースの作成
  def create
    @model_course = current_user.model_courses.new(model_course_params)

    if @model_course.save
      handle_image_attachments(@model_course, params)
      render json: { message: "モデルコースが作成されました", model_course: @model_course }, status: :created
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 🔹 モデルコースの更新
  def update
    if @model_course.update(model_course_params)
      handle_image_attachments(@model_course, params)
      render json: { message: "モデルコースが更新されました", model_course: @model_course }, status: :ok
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 🔹 モデルコースの削除
  def destroy
    @model_course.destroy
    render json: { message: "モデルコースが削除されました" }, status: :ok
  end

  private

  def set_model_course
    @model_course = ModelCourse.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "モデルコースが見つかりません" }, status: :not_found
  end

  def model_course_params
    params.require(:model_course).permit(:title, :description, :budget, :season, :genre_tags, :is_public, :theme_image, gallery_images: [])
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
