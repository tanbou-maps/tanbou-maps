class AddRoleToApplicationUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :application_users, :role, :string, default: 'user', null: false
  end
end
