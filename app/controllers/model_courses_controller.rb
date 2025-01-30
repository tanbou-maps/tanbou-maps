class ModelCoursesController < ApplicationController
  # 一覧表示
  def index
    @model_courses = ModelCourse
                        .includes(theme_image_attachment: :blob, application_user: {})
                        .order(updated_at: :desc)
                        .page(params[:page]).per(10)

    respond_to do |format|
      format.html # HTML ビューをレンダリング
      format.json { render json: {
        model_courses: @model_courses.as_json(only: [:id, :title, :description, :is_public]),
        current_page: @model_courses.current_page,
        total_pages: @model_courses.total_pages
      }}
    end
  end


  # 詳細表示
  def show
    @model_course = ModelCourse.find(params[:id])

    respond_to do |format|
      format.html # HTML ビューが必要な場合
      format.json do
        render json: {
          id: @model_course.id,
          title: @model_course.title,
          description: @model_course.description,
          is_public: @model_course.is_public,
          theme_image_url: @model_course.theme_image.attached? ? Rails.application.routes.url_helpers.url_for(@model_course.theme_image) : nil,
          gallery_image_urls: @model_course.gallery_image_urls,
          application_user: {
            id: @model_course.application_user.id,
            nickname: @model_course.application_user.nickname
          }
        }
      end
    end
  end

  # 新規作成フォーム
  def new
    @model_course = ModelCourse.new
  end

  # 作成処理
  def create
    @model_course = ModelCourse.new(model_course_params)
    @model_course.application_user_id = current_user.id # 作成者を設定

    Rails.logger.debug("ModelCourse attributes before save: #{@model_course.inspect}") # モデルの初期状態を記録

    if @model_course.save
      Rails.logger.debug("ModelCourse saved with ID: #{@model_course.id}")

      # テーマ画像を添付
      if params[:model_course][:theme_image].present?
        @model_course.theme_image.attach(params[:model_course][:theme_image])
        Rails.logger.debug("Theme image attached? #{@model_course.theme_image.attached?}") # 添付結果の確認
      else
        Rails.logger.debug("No theme image provided")
      end

      # ギャラリー画像を添付
      if params[:model_course][:gallery_images].present?
        params[:model_course][:gallery_images].each_with_index do |gallery_image, index|
          attachment_result = @model_course.gallery_images.attach(gallery_image)
          Rails.logger.debug("Gallery image ##{index + 1} attached: #{attachment_result.any?}")
        end
      else
        Rails.logger.debug("No gallery images provided")
      end

      render json: { message: "モデルコース作成成功！", model_course: @model_course }, status: :created
    else
      Rails.logger.debug("Model course save failed: #{@model_course.errors.full_messages}") # 保存失敗時のエラーメッセージ
      render json: { errors: @model_course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 編集フォーム
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

  # 公開キー再発行
  def regenerate_public_key
    @model_course = ModelCourse.find(params[:id])

    if @model_course.regenerate_public_key!
      redirect_to model_course_path(@model_course), notice: '公開キーが再発行されました。'
    else
      redirect_to model_course_path(@model_course), alert: '公開キーの再発行に失敗しました。'
    end
  end

  private

  # ストロングパラメータ
  def model_course_params
    params.require(:model_course).permit(
      :title,
      :description,
      :is_public,
      :theme_image,
      gallery_images: []
    )
  end
end
