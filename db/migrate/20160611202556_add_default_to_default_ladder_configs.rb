class AddDefaultToDefaultLadderConfigs < ActiveRecord::Migration
  def change
    add_column :default_ladder_configs, :is_default, :boolean, null: false, default: false
  end
end
