class ChangeStatusInReports < ActiveRecord::Migration
  def up
    change_column :reports, :status, :integer, default: 0
  end

  def down
    remove_column :reports, :status, :integer
    add_column :reports, :status, :integer
  end

end
