class AddApplicationUserToSpots < ActiveRecord::Migration[7.0]
  def change
    add_column :spots, :application_user_id, :bigint
    add_foreign_key :spots, :application_users
    add_index :spots, :application_user_id
  end
end
