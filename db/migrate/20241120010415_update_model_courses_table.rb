class UpdateModelCoursesTable < ActiveRecord::Migration[7.0]
  def change
    # public_keyにユニークインデックスを追加
    add_index :model_courses, :public_key, unique: true

    # is_publicのデフォルト値をfalseに変更
    change_column_default :model_courses, :is_public, from: true, to: false
  end
end
