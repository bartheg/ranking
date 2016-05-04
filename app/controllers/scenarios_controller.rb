class ScenariosController < ApplicationController

  def index
    if params[:ladder_id]
      @ladder = Ladder.find(params[:ladder_id].to_i)
      @header = "Scenarios of #{@ladder.name}"
      @scenarios = @ladder.scenarios

    else
      @header = "Scenarios"
      @scenarios = Scenario.all
    end
  end

end
