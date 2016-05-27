class RemoveMessageFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :message, :text
  end
end
