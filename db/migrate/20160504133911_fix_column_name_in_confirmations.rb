class FixColumnNameInConfirmations < ActiveRecord::Migration
  def change
        rename_column :confirmations, :value, :agree
  end
end
