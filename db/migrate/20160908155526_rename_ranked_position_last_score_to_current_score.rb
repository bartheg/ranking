class RenameRankedPositionLastScoreToCurrentScore < ActiveRecord::Migration
  def change
    rename_column :ranked_positions, :last_score, :current_score
  end
end
