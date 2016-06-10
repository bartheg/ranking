class CreateDefaultLadderConfigs < ActiveRecord::Migration
  def change
    create_table :default_ladder_configs do |t|
      t.integer :average_rating
      t.integer :loot_factor
      t.integer :loot_constant
      t.integer :disproportion_factor
      t.integer :draw_factor
      t.integer :hours_to_confirm

      t.timestamps null: false
    end
  end
end
