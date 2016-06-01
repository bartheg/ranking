class CreatePossibleResults < ActiveRecord::Migration
  def change
    create_table :possible_results do |t|
      t.integer :score_factor
      t.string :description
      t.integer :game_id

      t.timestamps null: false
    end
    add_index :possible_results, :game_id
  end
end
