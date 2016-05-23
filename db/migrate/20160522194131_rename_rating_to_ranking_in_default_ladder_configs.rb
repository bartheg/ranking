class RenameRatingToRankingInDefaultLadderConfigs < ActiveRecord::Migration
  def change
    rename_column :default_ladder_configs, :average_rating, :default_ranking
  end
end
