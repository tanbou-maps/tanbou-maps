class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.integer :stamp_count_required
      t.text :reward_description
      t.text :reward_image_url

      t.timestamps
    end
  end
end
