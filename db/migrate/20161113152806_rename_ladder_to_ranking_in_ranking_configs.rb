class RenameLadderToRankingInRankingConfigs < ActiveRecord::Migration
  def change
    rename_column :ranking_configs, :ladder_id, :ranking_id
  end
end
