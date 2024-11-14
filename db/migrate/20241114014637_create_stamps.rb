class CreateStamps < ActiveRecord::Migration[7.0]
  def change
    create_table :stamps do |t|
      t.integer :user_id
      t.integer :spot_id
      t.timestamp :date
      t.point :location
      t.text :method

      t.timestamps
    end
  end
end
