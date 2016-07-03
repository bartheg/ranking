class RenameLootConstantToMinPointsToGainInDefaultLadderConfigs < ActiveRecord::Migration
  def change
    rename_column :default_ladder_configs, :loot_constant, :min_points_to_gain
  end
end
