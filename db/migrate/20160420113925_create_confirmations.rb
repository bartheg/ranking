class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.references :report, index: true, foreign_key: true
      t.boolean :value
      t.text :message

      t.timestamps null: false
    end
  end
end
