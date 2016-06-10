class DropConfirmations < ActiveRecord::Migration

  def up
    drop_table :confirmations
  end

  def down
    create_table :confirmations do |t|
      t.references :report, index: true, foreign_key: true
      t.boolean :agree
      t.text :message

      t.timestamps null: false
    end

  end

end
