class RemoveStatusFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :status, :boolean
  end
end
