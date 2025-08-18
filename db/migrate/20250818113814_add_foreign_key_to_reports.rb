class AddForeignKeyToReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :reports, :user_id, :integer
    add_reference :reports, :user, null: false, foreign_key: true
  end
end
