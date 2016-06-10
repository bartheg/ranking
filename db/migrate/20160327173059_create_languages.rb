class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :iso_639_1
      t.string :english_name

      t.timestamps null: false
    end
  end
end
