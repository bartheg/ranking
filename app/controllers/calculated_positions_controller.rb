class CalculatedPositionsController < ApplicationController

  def index
    if params[:ranking_id]
      @ranking = Ranking.find(params[:ranking_id].to_i)
      @header = "Calculated Positions of #{@ranking.name}"
      @calculated_positions = @ranking.calculated_positions

    else
      @header = "Calculated Positions"
      @calculated_positions = CalculatedPosition.all
    end
  end

end
