class RemoveNameFromApplicationUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :application_users, :name, :string
  end
end
