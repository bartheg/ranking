class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.string :color

      t.timestamps null: false
    end
  end
end
