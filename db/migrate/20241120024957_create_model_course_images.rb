class CreateModelCourseImages < ActiveRecord::Migration[7.0]
  def change
    create_table :model_course_images do |t|
      t.references :model_course, null: false, foreign_key: true, type: :uuid
      t.string :url, null: false
      t.text :description

      t.timestamps
    end
  end
end
