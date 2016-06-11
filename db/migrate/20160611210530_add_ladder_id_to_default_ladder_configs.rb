class AddLadderIdToDefaultLadderConfigs < ActiveRecord::Migration
  def change
    add_column :default_ladder_configs, :ladder_id, :integer
    add_index :default_ladder_configs, :ladder_id, unique: true
  end
end
