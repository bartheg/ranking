class CreateLadders < ActiveRecord::Migration
  def change
    create_table :ladders do |t|
      t.string :name
      t.text :description
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :ladders, :name, unique: true
  end
end
