class ReportsToCalculateFinderService

  def initialize(lader)
    @ladd = lader
  end

  def tag_reports

    reps = @ladd.reports
    # puts reps.inspect
    # puts reps.size
    # reps.each do |r|
    #   puts r.inspect
    #   puts r.result.description
    # end
    # puts
    #
    # puts
    # puts @ladder.game.scenarios.inspect
    # puts @ladder.game.scenarios.size

    # reports.first.update(status: :to_calculate) if @ladder.reports.any?

    reps.each do |r|
      r.update(status: :to_calculate)
    end


  end

end
