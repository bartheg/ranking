class RenameRankingsToCalculatedPositions < ActiveRecord::Migration
  def change
    rename_table :rankings, :calculated_positions
  end
end
