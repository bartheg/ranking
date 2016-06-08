class CreateReportComments < ActiveRecord::Migration
  def change
    create_table :report_comments do |t|
      t.integer :report_id
      t.integer :profile_id
      t.text :message

      t.timestamps null: false
    end
    add_index :report_comments, :report_id
    add_index :report_comments, :profile_id
  end
end
