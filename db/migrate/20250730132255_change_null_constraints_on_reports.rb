class ChangeNullConstraintsOnReports < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reports, :title, false
    change_column_null :reports, :content, false
  end
end
