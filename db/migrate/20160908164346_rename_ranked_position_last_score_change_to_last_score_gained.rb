class RenameRankedPositionLastScoreChangeToLastScoreGained < ActiveRecord::Migration
  def change
    rename_column :ranked_positions, :last_score_change, :last_score_gained
  end
end
