class LeaderboardUpdater

  def self.update
    calculated_positions = CalculatedPosition.last 2

    calculated_positions.each do |calculated_position|
      update_position(old_position(calculated_position), calculated_position)
    end

  end

  private

  def self.getChange(calculated_position)
    current_score = calculated_position.value
    previous_report = CalculatedPosition.where(profile: calculated_position.profile).where(ladder: calculated_position.ladder).where(["id < ?", calculated_position.id]).last
    if previous_report
      return current_score - previous_report.value
    else
      return current_score - calculated_position.ladder.ladder_config.default_score
    end
  end

  def self.old_position(calculated_position)
    RankedPosition.where(profile: calculated_position.profile).where(ladder: calculated_position.ladder).first
  end

  def self.won?(profile, calculated_position)
    score_factor = calculated_position.report.result.score_factor
    if profile == calculated_position.report.reporter
      (score_factor > 50)? true : false
    else
      (score_factor < 50)? true : false
    end

  end

  def self.update_position(old_position, calculated_position)
    profile = calculated_position.profile
    score = calculated_position.value
    score_gained = getChange(calculated_position)
    last_match_at = calculated_position.report.created_at
    won = won?(profile, calculated_position)
    unless old_position
      ladder = calculated_position.ladder
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
