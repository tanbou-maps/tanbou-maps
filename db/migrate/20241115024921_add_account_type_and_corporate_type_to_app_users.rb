class AddAccountTypeAndCorporateTypeToAppUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :app_users, :account_type, :string, null: false, default: "individual"
    add_column :app_users, :corporate_type, :string
  end
end
