class RenameLadderToRankingInRankedPositions < ActiveRecord::Migration
  def change
    rename_column :ranked_positions, :ladder_id, :ranking_id
  end
end
