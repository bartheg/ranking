class ReportsCalculatingService

  def initialize(ladder)
    @ladder = ladder
    @max_distance_between_players = 1000 # 99% chance to win
    @unexpected_result_bonus = 15 # percentage of distance bonus
  end

  def calculate
    reports = collect
    reports.each do |report|
      rankings = from_report_to_rankings report
      rankings.each do |ranking|
        ranking.save
        # puts 'Ranking'
        # p ranking
        # puts 'Ranking report'
        # p ranking.report
      end
      report.status = 'calculated'
      report.save!
    end
  end

  def from_report_to_rankings(report)
    reporter_rank = Ranking.find_score(@ladder, report.reporter)
    confirmer_rank = Ranking.find_score(@ladder, report.confirmer)
    result = report.result.score_factor
    points_change = calculate_points(reporter_rank, confirmer_rank, result)
    reporter_rank += points_change
    confirmer_rank -= points_change
    [ Ranking.new(profile: report.reporter, ladder: @ladder, value: reporter_rank, report: report),
      Ranking.new(profile: report.confirmer, ladder: @ladder, value: confirmer_rank, report: report)
    ]
  end

  def collect
    @ladder.reports.to_calculate
  end

  def calculate_points(reporter, confirmer, result)
    def distance(reporter, confirmer)
      reporter - confirmer
    end

    def chance_to_win(distance)
      return 50 if distance == 0
      return 99 if distance >= @max_distance_between_players
      return 1 if distance <= -@max_distance_between_players
      50 + (distance.to_f / @max_distance_between_players * 50).round(0).to_i
    end

    def bonus_points(distance, result)
      return 0 if (distance == 0)
      return 0 if (distance > 0 and result >= 50)
      return 0 if (distance < 0 and result <= 50)
      calculated = -(distance.to_f * @unexpected_result_bonus / 100)
    end

    def gained_points(chance_to_win, result, bonus)
      (result - chance_to_win + bonus).round(0).to_i
    end

    dist = distance(reporter, confirmer)
    chance = chance_to_win(dist)
    bonus = bonus_points(dist, result)
    points = gained_points(chance, result, bonus)
  end



end
