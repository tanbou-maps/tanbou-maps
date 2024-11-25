class RemoveUserIdFromModelCourses < ActiveRecord::Migration[7.0]
  def change
    remove_column :model_courses, :user_id, :bigint
  end
end
