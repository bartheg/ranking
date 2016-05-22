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

  def show

  end

  def new
    @scenario = Scenario.new
    @ladder = Ladder.find(params[:ladder_id].to_i)
    @game = @ladder.game
    @scenario.ladder = @ladder
  end

  def create
    @ladder = Ladder.find(params[:ladder_id])
    @scenario = Scenario.new(scenario_params)
    @scenario.ladder = @ladder
    if @scenario.save
      redirect_to @scenario, notice: 'Scenario was successfully created.'
    else
      render :new
    end
  end


  private

  def set_scenario
    @scenario = Scenario.find(params[:id])
  end

  def scenario_params
    params.require(:scenario).permit(:full_name,:short_name, :description, :ladder_id, :map_size, :mirror_matchups_allowed, :map_random_generated)
  end

end
