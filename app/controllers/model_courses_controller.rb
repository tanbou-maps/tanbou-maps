class ModelCoursesController < ApplicationController
  before_action :set_model_course, only: [:show, :edit, :update, :destroy]
  before_action :require_sign_in, except: [:index, :show]

  # モデルコース一覧
  def index
    @sort_order = params[:sort] || 'created_at_desc'
    @model_courses = ModelCourse.includes(:application_user).order(sort_column + ' ' + sort_direction)

    if params[:search].present?
      @model_courses = @model_courses.where("title LIKE ? OR genre_tags LIKE ? OR season LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # 公開されているモデルコースと、現在のユーザーが作成した非公開のモデルコースを表示
    @model_courses = @model_courses.where("is_public = ? OR application_user_id = ?", true, current_user.id)

    respond_to do |format|
      format.html # HTMLビューを表示
      format.json do
        render json: @model_courses.map { |model_course|
          theme_image_url = model_course.theme_image.attached? ? url_for(model_course.theme_image) : nil
          gallery_image_urls = model_course.gallery_images.attached? ? model_course.gallery_images.map { |img| url_for(img) } : []
          model_course.as_json(
            only: [:id, :title, :description, :is_public, :budget, :season, :genre_tags],
            include: { application_user: { only: [:nickname] } }
          ).merge(
            theme_image_url: theme_image_url,
            gallery_image_urls: gallery_image_urls
          )
        }
      end
    end
  end

  # モデルコースの詳細
  def show
    if @model_course.is_public || @model_course.application_user == current_user
      theme_image_url = @model_course.theme_image.attached? ? url_for(@model_course.theme_image) : nil
      gallery_image_urls = @model_course.gallery_images.attached? ? @model_course.gallery_images.map { |img| url_for(img) } : []

      respond_to do |format|
        format.html # HTMLビューを表示
        format.json do
          render json: {
            model_course: @model_course.as_json(
              only: [:id, :title, :description, :is_public, :budget, :season, :genre_tags],
              include: { application_user: { only: [:nickname] } }
            ).merge(
              theme_image_url: theme_image_url,
              gallery_image_urls: gallery_image_urls
            )
          }
        end
      end
    else
      render json: { error: "このモデルコースは非公開です" }, status: :forbidden
    end
  end

  # 新規作成画面
  def new
    @model_course = ModelCourse.new
  end

  # 編集画面
  def edit
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
    if @model_course.update(model_course_params)
      render json: { message: "モデルコースが更新されました", model_course: @model_course }, status: :ok
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # モデルコースの削除
  def destroy
    if @model_course.application_user == current_user
      @model_course.destroy
      render json: { message: "モデルコースが削除されました" }, status: :ok
    else
      render json: { error: "このモデルコースを削除する権限がありません" }, status: :forbidden
    end
  end

  private

  def set_model_course
    @model_course = ModelCourse.find_by(id: params[:id])
    if @model_course.nil?
      render json: { error: "モデルコースが見つかりません" }, status: :not_found
    end
  end

  def sort_column
    case @sort_order
    when 'title_asc'
      'title'
    when 'title_desc'
      'title'
    when 'created_at_asc'
      'created_at'
    else
      'created_at'
    end
  end

  def sort_direction
    case @sort_order
    when 'title_asc'
      'asc'
    when 'title_desc'
      'desc'
    when 'created_at_asc'
      'asc'
    else
      'desc'
    end
  end

  def model_course_params

    params.require(:model_course).permit(:title, :description, :budget, :is_public, :season,  {genre_tags: []}, :theme_image, gallery_images: [])

  end
end
