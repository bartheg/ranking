class Ranking < ActiveRecord::Base
  belongs_to :ladder
  belongs_to :profile
  belongs_to :report

  def self.find_score(ladder, profile)
    ranking = self.where(profile: profile, ladder: ladder).last
    if ranking
      ranking.value
    else
      ladder.ladder_config.default_ranking
    end
  end
  
end
