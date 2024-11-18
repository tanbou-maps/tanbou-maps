class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :spot, null: false, foreign_key: true
      t.references :application_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
