class CreateReviewImages < ActiveRecord::Migration[7.0]
  def change
    create_table :review_images do |t|
      t.text :url
      t.text :description
      t.integer :review_id

      t.timestamps
    end
  end
end
