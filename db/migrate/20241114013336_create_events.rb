class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :capacity
      t.text :fee
      t.integer :spot_id

      t.timestamps
    end
  end
end
