class LeaderboardUpdater

  def self.update
    profile1 = Ranking.first.profile
    profile2 = Ranking.last.profile
    score_gained1 = getChange(Ranking.first)
    score_gained2 = getChange(Ranking.last)

    RankedPosition.create(profile: profile1, current_score: Ranking.first.value,
      ladder: Ranking.first.ladder, last_score_gained: score_gained1,
      last_match_at: profile1.rankings.last.report.created_at,
      number_of_confirmed_matches: 1,
      number_of_won_matches: (1 if profile1.rankings.last.report.result.score_factor > 50),
      scores_from_wins: (score_gained1 > 0)? score_gained1 : 0,
      average_win_score: ((score_gained1 > 0)? score_gained1 : 0)/1
      )

    RankedPosition.create(profile: profile2, current_score: Ranking.last.value,
      ladder: Ranking.last.ladder, last_score_gained: score_gained2,
      last_match_at: profile2.rankings.last.report.created_at,
      number_of_confirmed_matches: 1,
      number_of_won_matches: ((profile2.rankings.last.report.result.score_factor < 50)? 1 : 0),
      scores_from_wins: (score_gained2 > 0)? score_gained2 : 0,
      average_win_score: ((score_gained2 > 0)? score_gained2 : 0)/1
      )

  end

  private

  def self.getChange(ranking)
    current_score = ranking.value
    previous_report = Ranking.where(profile: ranking.profile).where(ladder: ranking.ladder).where(["id < ?", ranking.id]).last
    if previous_report
      return current_score - previous_report.value
    else
      return current_score - ranking.ladder.ladder_config.default_ranking
    end
  end

end
