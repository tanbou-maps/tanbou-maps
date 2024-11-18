class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :capacity
      t.text :fee
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
