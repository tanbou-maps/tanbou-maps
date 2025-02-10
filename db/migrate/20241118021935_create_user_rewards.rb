class CreateUserRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :user_rewards do |t|
      t.references :application_user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.datetime :obtained_at

      t.timestamps
    end
  end
end
