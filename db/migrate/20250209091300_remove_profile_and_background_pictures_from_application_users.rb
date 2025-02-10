class RemoveProfileAndBackgroundPicturesFromApplicationUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :application_users, :profile_picture_url, :text
    remove_column :application_users, :background_picture_url, :text
  end
end
