class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :scenario, index: true, foreign_key: true
      t.integer :reporter_id, index: true, foreign_key: true
      t.references :opponent, index: true, foreign_key: true
      t.references :reporters_faction, index: true, foreign_key: true
      t.references :opponents_faction, index: true, foreign_key: true
      t.text :message
      t.integer :result
      t.boolean :status
      t.boolean :calculated

      t.timestamps null: false
    end
  end
end
