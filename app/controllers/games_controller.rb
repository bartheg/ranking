class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  def index
    @games = Game.all
  end

  def show
    @results = @game.possible_results
  end

  def new
    @game = Game.new
    @game.description = "Type here something about the game."
    @game.possible_results << PossibleResult.new(description: "Victory", score_factor: 100)
    @game.possible_results << PossibleResult.new(description: "Defeat", score_factor: 0)
    @game.possible_results << PossibleResult.new(description: "Draw", score_factor: 50)
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.require(:game).permit(:full_name, :short_name, :description, :simultaneous_turns, possible_results_attributes: [:id, :description, :score_factor, :_destroy])
  end

end
