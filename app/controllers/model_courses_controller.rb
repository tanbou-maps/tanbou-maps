class ModelCoursesController < ApplicationController
  # 一覧表示
  def index
    @model_courses = ModelCourse.order(updated_at: :desc)

    # Vue.js 用に JSON レスポンスを返す
    respond_to do |format|
      format.html # HTML ビューが必要な場合
      format.json { render json: @model_courses }
  end
end

  # 詳細表示
  def show
    @model_course = ModelCourse.find(params[:id])
  end

  # 新規作成フォーム
  def new
    @model_course = ModelCourse.new
  end

  # 作成処理
  def create
    @model_course = ModelCourse.new(model_course_params)
    @model_course.application_user_id = current_user.id # 作成者を設定

    if @model_course.save
      redirect_to model_courses_path, notice: 'モデルコースが作成されました。'
    else
      render :new, status: :unprocessable_entity
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
    params.require(:model_course).permit(:title, :description, :theme_image_url, :is_public, model_course_images_attributes: [:url, :description, :_destroy])
  end
end
