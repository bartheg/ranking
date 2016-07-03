class RenameDefaultLadderConfigsToLadderConfigs < ActiveRecord::Migration
  def change
    rename_table :default_ladder_configs, :ladder_configs
  end
end
