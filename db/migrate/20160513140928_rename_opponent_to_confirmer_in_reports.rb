class RenameOpponentToConfirmerInReports < ActiveRecord::Migration
  def change
    rename_column :reports, :opponent_id, :confirmer_id
  end
end
