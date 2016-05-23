class RenameOpponentsFactionToConfirmersFactionInReports < ActiveRecord::Migration
  def change
    rename_column :reports, :opponents_faction_id, :confirmers_faction_id
  end
end
