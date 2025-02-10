class ModelCoursesController < ApplicationController
  # モデルコース一覧
  def index
    @model_courses = ModelCourse.includes(:application_user).order(created_at: :desc)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @model_courses }
    end
  end

  # モデルコースの詳細
  def show
    @model_course = ModelCourse.find(params[:id])
    theme_image_url = @model_course.theme_image.attached? ? url_for(@model_course.theme_image) : nil
    gallery_image_urls = @model_course.gallery_images.attached? ? @model_course.gallery_images.map { |img| url_for(img) } : []

    respond_to do |format|
      format.html { render :show }
      format.json do
        render json: {
          model_course: @model_course.as_json(
            only: [:id, :title, :description, :is_public, :budget, :season, :genre_tags],
            methods: [:genre_tags_array],
            include: { application_user: { only: [:nickname] } }
          ).merge(
            theme_image_url: theme_image_url,
            gallery_image_urls: gallery_image_urls
          )
        }
      end
    end
  end

  # モデルコースの作成
  def create
    @model_course = current_user.model_courses.new(model_course_params)

    if @model_course.save
      if params[:model_course][:theme_image].present?
        @model_course.theme_image.attach(params[:model_course][:theme_image])
      end

      if params[:model_course][:gallery_images].present?
        params[:model_course][:gallery_images].values.each do |image|
          @model_course.gallery_images.attach(image) if image.is_a?(ActionDispatch::Http::UploadedFile)
        end
      end

      render json: { message: "モデルコースが作成されました", model_course: @model_course }, status: :created
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # モデルコースの更新
  def update
    @model_course = ModelCourse.find(params[:id])

    if @model_course.update(model_course_params)
      if params[:model_course][:theme_image].present?
        @model_course.theme_image.attach(params[:model_course][:theme_image])
      end

      if params[:model_course][:gallery_images].present?
        params[:model_course][:gallery_images].values.each do |image|
          @model_course.gallery_images.attach(image) if image.is_a?(ActionDispatch::Http::UploadedFile)
        end
      end

      render json: { message: "モデルコースが更新されました", model_course: @model_course }, status: :ok
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # モデルコースの削除
  def destroy
    @model_course = ModelCourse.find(params[:id])
    @model_course.destroy
    render json: { message: "モデルコースが削除されました" }, status: :ok
  end

  private

  def model_course_params
    params.require(:model_course).permit(:title, :description, :budget, :season, {genre_tags: []}, :is_public, :theme_image, gallery_images: [])
  end
end
