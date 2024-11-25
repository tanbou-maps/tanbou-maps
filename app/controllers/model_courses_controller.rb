class ModelCoursesController < ApplicationController
  def index
    @model_courses = ModelCourse.includes(:application_user).all

    respond_to do |format|
      format.html # index.html.erbを表示
      format.json { render json: @model_courses.as_json(include: { application_user: { only: :nickname } }) }
    end
  end
end
