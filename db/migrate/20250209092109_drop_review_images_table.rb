class DropReviewImagesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :review_images
  end
end
