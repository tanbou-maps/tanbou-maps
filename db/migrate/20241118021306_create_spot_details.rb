class CreateSpotDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :spot_details do |t|
      t.references :spot, null: false, foreign_key: true
      t.text :hours_of_operation
      t.text :access_info
      t.text :contact_info
      t.text :website_url
      t.text :recommended_season
      t.text :entry_fee

      t.timestamps
    end
  end
end
