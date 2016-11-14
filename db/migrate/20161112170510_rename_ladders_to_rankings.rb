class RenameLaddersToRankings < ActiveRecord::Migration
  def change
    rename_table :ladders, :rankings
  end
end
