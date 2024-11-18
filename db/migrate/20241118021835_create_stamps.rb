class CreateStamps < ActiveRecord::Migration[7.0]
  def change
    create_table :stamps do |t|
      t.references :application_user, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true
      t.datetime :date
      t.point :location
      t.text :method

      t.timestamps
    end
  end
end
