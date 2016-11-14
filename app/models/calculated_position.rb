class CalculatedPosition < ActiveRecord::Base
  belongs_to :ranking
  belongs_to :profile
  belongs_to :report

  # after_create :update_leaderboard

  def self.find_score(ranking, profile)
    calculated_position = self.where(profile: profile, ranking: ranking).last
    if calculated_position
      calculated_position.value
    else
      ranking.ranking_config.default_calculated_position
    end
  end


  # private
  #
  # def update_leaderboard
  #   RankedPosition.create
  # end

end
