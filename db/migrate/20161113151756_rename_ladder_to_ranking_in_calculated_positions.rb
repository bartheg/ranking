class RenameLadderToRankingInCalculatedPositions < ActiveRecord::Migration
  def change
    rename_column :calculated_positions, :ladder_id, :ranking_id
  end
end
