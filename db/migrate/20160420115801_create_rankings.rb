class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :ladder, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true
      t.integer :value
      t.references :report, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
