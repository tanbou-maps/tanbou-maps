class AddUserIdAndUpdateNicknameToApplicationUsers < ActiveRecord::Migration[7.0]
  def change
    # user_id を追加
    add_column :application_users, :user_id, :string, null: false, unique: true

    # nickname を username にリネーム
    rename_column :application_users, :nickname, :username

    # ユーザIDにユニーク制約を追加
    add_index :application_users, :user_id, unique: true
  end
end
