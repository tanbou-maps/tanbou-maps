class RemoveUuidFromModelCourses < ActiveRecord::Migration[7.0]
  def change
    remove_column :model_courses, :record_uuid, :string
  end
end
