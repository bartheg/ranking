class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.string :full_name
      t.string :short_name
      t.text :description
      t.boolean :mirror_matchups_allowed
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
