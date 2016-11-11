class CalculatedPosition < ActiveRecord::Base
  belongs_to :ladder
  belongs_to :profile
  belongs_to :report

  # after_create :update_leaderboard

  def self.find_score(ladder, profile)
    calculated_position = self.where(profile: profile, ladder: ladder).last
    if calculated_position
      calculated_position.value
    else
      ladder.ladder_config.default_calculated_position
    end
  end


  # private
  #
  # def update_leaderboard
  #   RankedPosition.create
  # end

end
