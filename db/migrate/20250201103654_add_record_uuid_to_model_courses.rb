class AddRecordUuidToModelCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :model_courses, :record_uuid, :string, null: false, default: -> { "gen_random_uuid()" }
    add_index :model_courses, :record_uuid, unique: true
  end
end
