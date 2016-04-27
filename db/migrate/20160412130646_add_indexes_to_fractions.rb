class AddIndexesToFractions < ActiveRecord::Migration
  def up
    add_index :factions, :full_name, unique: true
    add_index :factions, :short_name, unique: true
  end

  def down
    drop_table :factions

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
