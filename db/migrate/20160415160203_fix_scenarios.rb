class FixScenarios < ActiveRecord::Migration
  def up
    remove_column :scenarios, :game_id
    add_column :scenarios, :ladder_id, :integer, index: true, foreign_key: true
  end

  def down
    remove_column :scenarios, :ladder_id
    add_column :scenarios, :game_id, :integer, index: true, foreign_key: true #ladder instead of game

  end

end
