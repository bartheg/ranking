class RenameLadderToRankingInScenarios < ActiveRecord::Migration
  def change
    rename_column :scenarios, :ladder_id, :ranking_id
  end
end
