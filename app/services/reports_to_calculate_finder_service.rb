class ReportsToCalculateFinderService

  def initialize(report)
    @starting_report = report
    @ladder = @starting_report.scenario.ladder
  end

  def tag_to_calculate(report = @starting_report)

    def try_to_tag_to_calculate_this_report(report)
      if report.confirmed?
        player1_previous = report.previous(report.reporter)
        player2_previous = report.previous(report.confirmer)
        if ((player1_previous == nil || ['to_calculate', 'calculated'].include?(player1_previous.status)) && (player2_previous == nil || ['to_calculate', 'calculated'].include?(player2_previous.status)))
          report.update(status: :to_calculate)
        end
      end
    end

    try_to_tag_to_calculate_this_report(report)
    reporter_next_report = find_next(report, report.reporter)
    confirmer_next_report = find_next(report, report.confirmer)
    if reporter_next_report
      tag_to_calculate(reporter_next_report)
    end
    if confirmer_next_report
      tag_to_calculate(confirmer_next_report)
    end

  end

  private

  def find_next(report, player)
    Report.where(scenario_id: report.scenario.id).where(["reporter_id = ? OR confirmer_id = ?", player.id, player.id]).where(["id > ?", report.id]).first
  end

end
