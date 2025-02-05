class AddDetailsToModelCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :model_courses, :budget, :integer
    add_column :model_courses, :season, :string
    add_column :model_courses, :genre_tags, :text
  end
end
