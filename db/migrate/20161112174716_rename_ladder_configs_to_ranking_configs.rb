class RenameLadderConfigsToRankingConfigs < ActiveRecord::Migration
  def change
    rename_table :ladder_configs, :ranking_configs
  end
end
