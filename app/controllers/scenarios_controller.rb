class ScenariosController < ApplicationController

  before_action :set_scenario, only: [:show]

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

  def new
    @scenario = Scenario.new
    @ladder = Ladder.find(params[:ladder_id].to_i)
    @scenario.ladder = @ladder
  end

  def show

  end


  private

  def set_scenario
    @scenario = Scenario.find(params[:id])
  end

  def scenario_params
    params.require(:scenario).permit(:name, :description, :ladder_id)
  end

end
