class CalculatedPositionsController < ApplicationController

  def index
    if params[:ladder_id]
      @ladder = Ladder.find(params[:ladder_id].to_i)
      @header = "Calculated Positions of #{@ladder.name}"
      @calculated_positions = @ladder.calculated_positions

    else
      @header = "Calculated Positions"
      @calculated_positions = CalculatedPosition.all
    end
  end

end
