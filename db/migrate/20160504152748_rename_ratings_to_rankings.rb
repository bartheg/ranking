class RenameRatingsToRankings < ActiveRecord::Migration
  def change
    rename_table :ratings, :rankings
  end
end
