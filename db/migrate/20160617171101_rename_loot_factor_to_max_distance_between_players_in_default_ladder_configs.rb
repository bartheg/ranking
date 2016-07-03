class RenameLootFactorToMaxDistanceBetweenPlayersInDefaultLadderConfigs < ActiveRecord::Migration
  def change
    rename_column :default_ladder_configs, :loot_factor, :max_distance_between_players
  end
end
