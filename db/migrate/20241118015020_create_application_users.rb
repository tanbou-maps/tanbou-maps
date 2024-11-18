class CreateApplicationUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :application_users do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.string :account_type
      t.string :corporate_type
      t.text :profile_picture_url
      t.text :background_picture_url
      t.text :favorite_spots

      t.timestamps
    end
    add_index :application_users, :email
  end
end
