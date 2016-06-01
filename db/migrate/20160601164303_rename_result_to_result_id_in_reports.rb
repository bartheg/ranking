class RenameResultToResultIdInReports < ActiveRecord::Migration
  def change
    rename_column :reports, :result, :result_id
  end
end
