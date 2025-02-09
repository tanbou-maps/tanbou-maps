class RemoveThemeImageUrlFromModelCourses < ActiveRecord::Migration[7.0]
  def change
    remove_column :model_courses, :theme_image_url, :string
  end
end
