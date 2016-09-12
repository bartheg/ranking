class CreateRankedPositions < ActiveRecord::Migration
  def change
    create_table :ranked_positions do |t|
      t.references :ladder, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true
      t.integer :last_score
      t.integer :last_score_change
      t.datetime :last_match_at
      t.integer :number_of_confirmed_matches
      t.integer :number_of_won_matches
      t.integer :scores_from_wins
      t.integer :average_win_score

      t.timestamps null: false
    end
    add_index :ranked_positions, :last_score
    add_index :ranked_positions, :number_of_confirmed_matches
    add_index :ranked_positions, :number_of_won_matches
    add_index :ranked_positions, :average_win_score
  end
end
