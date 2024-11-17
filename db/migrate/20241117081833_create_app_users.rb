class CreateAppUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :app_users do |t|
      t.string :name
      t.text :email
      t.string :password
      t.text :bio
      t.string :account_atatus
      t.text :profile_picture_url
      t.text :location
      t.string :account_type
      t.string :corporate_type, default: 'individual'

      t.timestamps
    end
  end
end
