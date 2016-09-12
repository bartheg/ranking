class Ranking < ActiveRecord::Base
  belongs_to :ladder
  belongs_to :profile
  belongs_to :report

  # after_create :update_leaderboard

  def self.find_score(ladder, profile)
    ranking = self.where(profile: profile, ladder: ladder).last
    if ranking
      ranking.value
    else
      ladder.ladder_config.default_ranking
    end
  end


  # private
  #
  # def update_leaderboard
  #   RankedPosition.create
  # end

end
