class DropModelCourseImagesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :model_course_images
  end
end
