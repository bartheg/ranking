class LeaderboardUpdater

  def self.update
    rankings = Ranking.last 2

    rankings.each do |ranking|
      update_position(old_position(ranking), ranking)
    end

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

  def self.old_position(ranking)
    RankedPosition.where(profile: ranking.profile).where(ladder: ranking.ladder).first
  end

  def self.won?(profile, ranking)
    score_factor = ranking.report.result.score_factor
    if profile == ranking.report.reporter
      (score_factor > 50)? true : false
    else
      (score_factor < 50)? true : false
    end

  end

  def self.update_position(old_position, ranking)
    profile = ranking.profile
    score = ranking.value
    score_gained = getChange(ranking)
    last_match_at = ranking.report.created_at
    won = won?(profile, ranking)
    unless old_position
      ladder = ranking.ladder
      number_of_matches = 1
      number_of_won_matches = won ? 1 : 0
      scores_from_wins = (number_of_won_matches == 1)? score_gained : 0
      average_win_score = (number_of_won_matches == 1)? (scores_from_wins/number_of_won_matches) : 0

      RankedPosition.create(
        profile: profile,
        ladder: ladder,
        current_score: score,
        last_score_gained: score_gained,
        last_match_at: last_match_at,
        number_of_confirmed_matches: number_of_matches,
        number_of_won_matches: number_of_won_matches,
        scores_from_wins: scores_from_wins,
        average_win_score: average_win_score
      )
    else
      number_of_matches = old_position.number_of_confirmed_matches + 1
      number_of_won_matches = old_position.number_of_won_matches + (won ? 1 : 0)
      old_winscores = old_position.scores_from_wins
      scores_from_wins = (won ? old_winscores + score_gained : old_winscores)
      average_win_score = (number_of_won_matches > 0)? (scores_from_wins/number_of_won_matches) : 0

      old_position.update(
        current_score: score,
        last_score_gained: score_gained,
        last_match_at: last_match_at,
        number_of_confirmed_matches: number_of_matches,
        number_of_won_matches: number_of_won_matches,
        scores_from_wins: scores_from_wins,
        average_win_score: average_win_score
      )
    end

  end

end
