class ModelCoursesController < ApplicationController
  # 一覧表示
  def index
    @model_courses = ModelCourse
                        .includes(:application_user)
                        .order(updated_at: :desc)
                        .page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          model_courses: @model_courses.as_json(
            only: [:id, :record_uuid, :title, :description, :is_public, :budget, :season, :genre_tags],
            methods: [:genre_tags_array, :theme_image_url], # ここで `theme_image_url` を追加
            include: { application_user: { only: [:nickname] } }
          ),
          current_page: @model_courses.current_page,
          total_pages: @model_courses.total_pages
        }
      end
    end
  end

  # 詳細表示
  def show
    @model_course = ModelCourse.find_by(record_uuid: params[:record_uuid])
    return render json: { error: "Model Course not found" }, status: :not_found unless @model_course

    theme_image_url = @model_course.theme_image.attached? ? url_for(@model_course.theme_image) : nil
    gallery_image_urls = @model_course.gallery_images.attached? ? @model_course.gallery_images.map { |img| url_for(img) } : []

    render json: {
      model_course: @model_course.as_json(
        only: [:id, :title, :description, :is_public, :budget, :season, :genre_tags, :record_uuid],
        methods: [:genre_tags_array],
        include: { application_user: { only: [:nickname] } }
      ).merge(
        theme_image_url: theme_image_url,
        gallery_image_urls: gallery_image_urls
        )
    }
  end








  # 新規作成
  def new
    @model_course = ModelCourse.new
  end

  # 作成処理
  def create
    @model_course = ModelCourse.new(model_course_params)
    @model_course.record_uuid = SecureRandom.uuid

    if @model_course.save
      @model_course.theme_image.attach(params[:theme_image]) if params[:theme_image].present?

      render json: { model_course: @model_course }, status: :created
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end





  # 編集
  def edit
    @model_course = ModelCourse.find(params[:id])
  end

  # 更新処理
  def update
    @model_course = ModelCourse.find(params[:id])

    if @model_course.update(model_course_params)
      redirect_to model_course_path(@model_course), notice: 'モデルコースが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除処理
  def destroy
    @model_course = ModelCourse.find(params[:id])

    if @model_course.destroy
      render json: { message: "モデルコースが削除されました。" }, status: :ok
    else
      render json: { message: "モデルコースの削除に失敗しました。" }, status: :unprocessable_entity
    end
  end

  private

  def model_course_params
    params.require(:model_course).permit(
      :title,
      :description,
      :is_public,
      :budget,
      :season,
      :genre_tags,
      :theme_image,
      gallery_images: []
    )
  end
end
