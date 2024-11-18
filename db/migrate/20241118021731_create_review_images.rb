class CreateReviewImages < ActiveRecord::Migration[7.0]
  def change
    create_table :review_images do |t|
      t.text :url
      t.text :description
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
