class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.references :source_report, null: false, foreign_key: { to_table: :reports }
      t.references :target_report, null: false, foreign_key: { to_table: :reports }

      t.timestamps
    end
    add_index :mentions, [:source_report_id, :target_report_id], unique: true
  end
end
