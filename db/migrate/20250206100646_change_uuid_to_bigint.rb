class ChangeUuidToBigint < ActiveRecord::Migration[7.0]
  def change
    # 外部キー制約を削除
    remove_foreign_key :course_spots, :model_courses

    # `model_courses` の `id` を変更
    remove_column :model_courses, :id, :uuid
    add_column :model_courses, :id, :bigserial, primary_key: true

    # `course_spots` の `model_course_id` を `bigint` に変更
    remove_column :course_spots, :model_course_id
    add_column :course_spots, :model_course_id, :bigint, null: false

    # 外部キー制約を再追加
    add_foreign_key :course_spots, :model_courses
  end
end
