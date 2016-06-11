class RemoveCalculatedFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :calculated, :boolean
  end
end
