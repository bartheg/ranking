class RemoveConfirmedFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :confirmed, :boolean
  end
end
