class CreateCourseSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :course_spots, id: :uuid do |t|
      t.references :model_course, null: false, foreign_key: true, type: :uuid
      t.references :spot, null: false, foreign_key: true, type: :bigint
      t.integer :order_number, null: false
      t.integer :stay_time_minutes
      t.string :transportation

      t.timestamps
    end

    add_index :course_spots, [:model_course_id, :order_number], unique: true
  end
end
