class DropProfileNameEditTable < ActiveRecord::Migration
  def up
    drop_table :profile_name_edits
  end

  def down
    create_table :profile_name_edits do |t|
      t.references :profile, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
    add_index :profile_name_edits, :name
  end
end
