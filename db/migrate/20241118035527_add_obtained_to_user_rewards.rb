class AddObtainedToUserRewards < ActiveRecord::Migration[7.0]
  def change
    add_column :user_rewards, :obtained, :boolean, default: false, null: false
  end
end
