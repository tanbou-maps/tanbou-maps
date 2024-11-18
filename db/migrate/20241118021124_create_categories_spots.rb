class CreateCategoriesSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :categories_spots do |t|
      t.references :category, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
