class RenameDefaultRankingToDefaultScoreInLadderConfigs < ActiveRecord::Migration
  def change
    rename_column :ladder_configs, :default_ranking, :default_score
  end
end
