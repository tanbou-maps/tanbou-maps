class AddStatusToStamps < ActiveRecord::Migration[7.0]
  def change
    add_column :stamps, :status, :string, default: 'pending', null: false
  end
end
