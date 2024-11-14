class CreateAppUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :app_users do |t|
      t.string :name
      t.text :email
      t.text :bio
      t.string :account_status
      t.text :profile_picture_url
      t.text :location

      t.timestamps
    end
  end
end
