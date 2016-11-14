class RankingsController < ApplicationController

  before_action :set_ranking, only: [:show]

  def index
    if params[:game_id]
      @game = Game.find(params[:game_id].to_i)
      @header = "Rankings of #{@game.short_name}"
      @rankings = @game.rankings

    else
      @header = "Rankings"
      @rankings = Ranking.includes(:game, :scenarios)
    end
  end

  def show
    @config = @ranking.ranking_config
    @ranked_positions = @ranking.ranked_positions
  end

  def new
    @game = Game.find(params[:game_id].to_i)
    @ranking = Ranking.new
    @ranking.game = @game
  end

  def create
    @game = Game.find(params[:game_id])
    @ranking = Ranking.new(ranking_params)
    @ranking.game = @game
    if @ranking.save
      redirect_to @ranking, notice: 'Ranking was successfully created.'
    else
      render :new
    end
  end

  private

  def set_ranking
    @ranking = Ranking.find(params[:id])
  end

  def ranking_params
    params.require(:ranking).permit(:name, :description)
  end

end
