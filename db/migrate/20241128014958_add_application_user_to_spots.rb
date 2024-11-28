class AddApplicationUserToSpots < ActiveRecord::Migration[7.0]
  def change
    add_reference :spots, :application_user, null: false, foreign_key: true
  end
end
