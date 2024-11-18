class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.text :name
      t.text :description
      t.point :location
      t.integer :popularity_score

      t.timestamps
    end
  end
end
