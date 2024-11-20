class CreateModelCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :model_courses, id: :uuid do |t|
      t.string :title, null: false
      t.text :description
      t.string :theme_image_url
      t.references :user, null: false, foreign_key: { to_table: :application_users }, type: :bigint
      t.boolean :is_public, default: true, null: false
      t.string :public_key, null: false

      t.timestamps
    end

    add_index :model_courses, :public_key, unique: true
  end
end
