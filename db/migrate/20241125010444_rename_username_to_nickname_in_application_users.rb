class RenameUsernameToNicknameInApplicationUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :application_users, :username, :nickname
  end
end
