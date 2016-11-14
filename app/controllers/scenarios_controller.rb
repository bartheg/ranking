class ScenariosController < ApplicationController

  before_action :set_scenario, only: [:show]

  def index
    if params[:ranking_id]
      @ranking = Ranking.find(params[:ranking_id].to_i)
      @header = "Scenarios of #{@ranking.name}"
      @scenarios = @ranking.scenarios

    else
      @header = "Scenarios"
      @scenarios = Scenario.all
    end
  end

  def show

  end

  def new
    @scenario = Scenario.new
    @ranking = Ranking.find(params[:ranking_id].to_i)
    @game = @ranking.game
    @scenario.ranking = @ranking
  end

  def create
    @ranking = Ranking.find(params[:ranking_id])
    @scenario = Scenario.new(scenario_params)
    @scenario.ranking = @ranking
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
    params.require(:scenario).permit(:full_name,:short_name, :description, :ranking_id, :map_size, :mirror_matchups_allowed, :map_random_generated)
  end

end
