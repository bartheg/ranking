class RenameDrawFactorToUnexpectedResultBonusInDefaultLadderConfigs < ActiveRecord::Migration
  def change
    rename_column :default_ladder_configs, :draw_factor, :unexpected_result_bonus
  end
end
