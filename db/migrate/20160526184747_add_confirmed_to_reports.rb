class AddConfirmedToReports < ActiveRecord::Migration
  def change
    add_column :reports, :confirmed, :boolean
  end
end
