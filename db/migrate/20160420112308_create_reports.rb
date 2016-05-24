class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :scenario, index: true, foreign_key: true
      t.integer :reporter_id, index: true, foreign_key: true
      t.integer :opponent_id, index: true, foreign_key: true
      t.integer :reporters_faction_id, index: true, foreign_key: true
      t.integer :opponents_faction_id, index: true, foreign_key: true
      t.text :message
      t.integer :result
      t.boolean :status
      t.boolean :calculated

      t.timestamps null: false
    end
  end
end
