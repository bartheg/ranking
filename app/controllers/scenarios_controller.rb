class ScenariosController < ApplicationController

  before_action :set_scenario, only: [:show]

  def index
    if params[:ranking_id]
      @ranking = Ranking.find(params[:ranking_id].to_i)
      @header = "Scenarios of #{@ranking.name}"
      @scenarios = @ranking.scenarios
      add_breadcrumb "Games", :games_path
      add_breadcrumb @ranking.game.short_name, @ranking.game
      add_breadcrumb "rankings", game_rankings_path(@ranking.game)
      add_breadcrumb @ranking.name, @ranking
      add_breadcrumb "scenarios", :ranking_scenarios_path

    else
      @header = "Scenarios"
      @scenarios = Scenario.all
      add_breadcrumb "Scenarios", scenarios_path

    end
  end

  def show
    add_breadcrumb "Games", :games_path
    add_breadcrumb @scenario.ranking.game.short_name, @scenario.ranking.game
    add_breadcrumb "rankings", game_rankings_path(@scenario.ranking.game)
    add_breadcrumb @scenario.ranking.name, @scenario.ranking
    add_breadcrumb "scenarios", ranking_scenarios_path(@scenario.ranking)
    add_breadcrumb @scenario.short_name, @scenario

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
