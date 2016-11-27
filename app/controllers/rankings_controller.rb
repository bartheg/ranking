class RankingsController < ApplicationController

  before_action :set_ranking, only: [:show]

  def index
    if params[:game_id]
      @game = Game.find(params[:game_id].to_i)
      @header = "Rankings of #{@game.short_name}"
      @rankings = @game.rankings
      add_breadcrumb @game.short_name, @game
      add_breadcrumb "Rankings", :rankings_path


    else
      @header = "Rankings"
      @rankings = Ranking.includes(:game, :scenarios)
      add_breadcrumb "Rankings", :rankings_path

    end
  end

  def show
    @config = @ranking.ranking_config
    @ranked_positions = @ranking.ranked_positions
    add_breadcrumb @ranking.game.short_name, @ranking.game
    add_breadcrumb "rankings", game_rankings_path(@ranking.game)
    add_breadcrumb @ranking.name, @ranking

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
