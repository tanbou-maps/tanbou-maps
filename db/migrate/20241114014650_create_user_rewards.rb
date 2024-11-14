class CreateUserRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :user_rewards do |t|
      t.integer :user_id
      t.integer :reward_id
      t.timestamp :obtained_at

      t.timestamps
    end
  end
end
