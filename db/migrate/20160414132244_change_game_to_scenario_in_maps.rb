class ChangeGameToScenarioInMaps < ActiveRecord::Migration
  def up
    drop_table :maps
    create_table :maps do |t|
      t.string :full_name
      t.string :short_name
      t.string :size
      t.text :description
      t.boolean :random_generated
      t.references :scenario, index: true, foreign_key: true
      t.timestamps null: false
    end
  end

  def down
    drop_table :maps
    create_table :maps do |t|
      t.string :full_name
      t.string :short_name
      t.string :size
      t.text :description
      t.boolean :random_generated
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end

end
