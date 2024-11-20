class AddNullConstraintToPublicKeyInModelCourses < ActiveRecord::Migration[7.0]
  def change
    change_column_null :model_courses, :public_key, false
  end
end
