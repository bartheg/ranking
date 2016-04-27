class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :full_name
      t.string :short_name
      t.text :description
      t.boolean :simultaneous_turns

      t.timestamps null: false
    end
    add_index :games, :full_name, unique: true
    add_index :games, :short_name, unique: true
  end
end
