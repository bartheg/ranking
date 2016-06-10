class CreateFactions < ActiveRecord::Migration
  def change
    create_table :factions do |t|
      t.string :full_name
      t.string :short_name
      t.text :description
      t.boolean :scenario_dependent
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
