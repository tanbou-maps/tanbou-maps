class AddApplicationUserIdToModelCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :model_courses, :application_user_id, :bigint
    add_foreign_key :model_courses, :application_users
    add_index :model_courses, :application_user_id
  end
end
