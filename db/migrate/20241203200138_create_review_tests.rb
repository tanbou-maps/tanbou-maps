class CreateReviewTests < ActiveRecord::Migration[7.0]
  def change
    create_table :review_tests do |t|
      t.string :title
      t.text :memo

      t.timestamps
    end
  end
end
