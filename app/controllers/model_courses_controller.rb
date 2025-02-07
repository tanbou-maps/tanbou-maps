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

    render json: {
      model_course: @model_course.as_json(
        only: [:id, :title, :description, :is_public, :budget, :season, :genre_tags, :record_uuid],
        methods: [:genre_tags_array, :theme_image_url, :gallery_image_urls],
        include: { application_user: { only: [:nickname] } }
      )
    }
  end


  # 新規作成
  def new
    @model_course = ModelCourse.new
  end

  # 作成処理
  def create
    @model_course = current_user.model_courses.new(model_course_params)

    if @model_course.save
      # 画像の添付処理は save 後に行う
      @model_course.theme_image.attach(params[:model_course][:theme_image]) if params[:model_course][:theme_image].present?

      # 🛠 修正: 既存のギャラリー画像をクリアしてから新しい画像を追加
      if params[:model_course][:gallery_images].present?
        @model_course.gallery_images.purge # 既存の画像を削除
        @model_course.gallery_images.attach(params[:model_course][:gallery_images])
      end

      render json: {
        message: "モデルコースが作成されました",
        model_course: @model_course.as_json(
          only: [:id, :title, :description, :is_public, :budget, :season, :genre_tags, :record_uuid],
          methods: [:genre_tags_array],
          include: { application_user: { only: [:nickname] } }
        ).merge(
          theme_image_url: @model_course.theme_image.attached? ? url_for(@model_course.theme_image) : nil,
          gallery_image_urls: @model_course.gallery_images.map { |img| url_for(img) }
        )
      }, status: :created
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
    Rails.logger.debug "update 呼び出し: record_uuid=#{params[:record_uuid]}"
    unless @model_course
      Rails.logger.error "モデルコースが nil のため更新不可: record_uuid=#{params[:record_uuid]}"
      render json: { error: "モデルコースが見つかりません" }, status: :not_found
      return
    end

    if @model_course.update(model_course_params)
      update_images(@model_course, params)
      @model_course.reload  # 画像の変更を即時反映
      render json: { message: "モデルコースが更新されました" }, status: :ok
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end





  # 削除処理
  def destroy
    @model_course = current_user.model_courses.find_by(record_uuid: params[:record_uuid])
    return render json: { error: "モデルコースが見つかりません" }, status: :not_found unless @model_course

    # もし `Favorite` モデルが存在すれば関連する `favorites` を削除
    @model_course.favorites.destroy_all if defined?(Favorite) && @model_course.respond_to?(:favorites)
    @model_course.likes.destroy_all if defined?(Like) && @model_course.respond_to?(:likes)

    # 画像がある場合、削除処理を実行
    @model_course.theme_image.purge if @model_course.theme_image.attached?
    @model_course.gallery_images.purge_later if @model_course.gallery_images.attached?

    # モデルコース本体を削除
    if @model_course.destroy
      render json: { message: "モデルコースが削除されました" }, status: :ok
    else
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  rescue NameError => e
    Rails.logger.error "モデル削除時のエラー: #{e.message}"
    render json: { error: "削除中にエラーが発生しました" }, status: :internal_server_error
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
      gallery_images: [],
      remove_images: []
    ).except(:theme_image_url, :application_user, :genre_tags_array)
  end

  def set_model_course
    Rails.logger.debug "set_model_course 呼び出し: record_uuid=#{params[:record_uuid]}"
    @model_course = ModelCourse.find_by(record_uuid: params[:record_uuid])
    unless @model_course
      Rails.logger.error "モデルコースが見つかりません: record_uuid=#{params[:record_uuid]}"
      render json: { error: "モデルコースが見つかりません" }, status: :not_found
      return
    end
  end


  # 更新時の画像処理（削除 & 追加）
  def update_images(model_course, params)
    # 既存のテーマ画像を削除して新しいものに置き換え
    if params[:model_course][:theme_image].present?
      model_course.theme_image.purge if model_course.theme_image.attached?
      model_course.theme_image.attach(params[:model_course][:theme_image])
    end

    # ギャラリー画像の削除処理
    if params[:model_course][:remove_images].present?
      params[:model_course][:remove_images].each do |image_url|
        image = model_course.gallery_images.find { |img| url_for(img) == image_url }
        image.purge if image
      end
    end

    # 新しいギャラリー画像の追加
    if params[:model_course][:gallery_images].present?
      params[:model_course][:gallery_images].each do |image|
        model_course.gallery_images.attach(image)
      end
    end
  end


end
