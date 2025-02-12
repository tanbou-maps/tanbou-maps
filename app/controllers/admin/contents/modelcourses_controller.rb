class Admin::Contents::ModelcoursesController < Admin::BaseController
  before_action :set_model_course, only: %i[destroy]

  def index
    @modelcourses = ModelCourse.order(created_at: :desc)
  end

  def destroy
    if @modelcourse.destroy
      redirect_to admin_contents_modelcourses_path, notice: 'モデルコースが削除されました。'
    else
      redirect_to admin_contents_modelcourses_path, alert: 'モデルコースの削除に失敗しました。'
    end
  end

  private

  def set_model_course
    @modelcourse = ModelCourse.find(params[:id])
  end
end
