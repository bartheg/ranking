class FixScenarios < ActiveRecord::Migration
  def up
    drop_table :scenarios

    create_table :scenarios do |t|
      t.string :full_name
      t.string :short_name
      t.text :description
      t.boolean :mirror_matchups_allowed
      t.references :ladder, index: true, foreign_key: true #ladder instead of game
      t.string :map_size
      t.boolean :map_random_generated

      t.timestamps null: false
    end

  end

  def down
    drop_table :scenarios

    create_table :scenarios do |t|
      t.string :full_name
      t.string :short_name
      t.text :description
      t.boolean :mirror_matchups_allowed
      t.references :game, index: true, foreign_key: true
      t.string :map_size
      t.boolean :map_random_generated

      t.timestamps null: false
    end

  end
end
