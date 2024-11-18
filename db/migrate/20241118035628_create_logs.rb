class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.references :application_user, null: false, foreign_key: true
      t.string :action_type, null: false
      t.integer :target_id
      t.text :details

      t.timestamps
    end
  end
end
