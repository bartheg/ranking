class LaddersController < ApplicationController

  before_action :set_ladder, only: [:show]

  def index
    if params[:game_id]
      @game = Game.find(params[:game_id].to_i)
      @header = "Ladders of #{@game.short_name}"
      @ladders = @game.ladders

    else
      @header = "Ladders"
      @ladders = Ladder.all
    end
  end

  def show
    @config = @ladder.ladder_config
  end

  def new
    @game = Game.find(params[:game_id].to_i)
    @ladder = Ladder.new
    @ladder.game = @game
  end

  def create
    @game = Game.find(params[:game_id])
    @ladder = Ladder.new(ladder_params)
    @ladder.game = @game
    if @ladder.save
      redirect_to @ladder, notice: 'Ladder was successfully created.'
    else
      render :new
    end
  end

  private

  def set_ladder
    @ladder = Ladder.find(params[:id])
  end

  def ladder_params
    params.require(:ladder).permit(:name, :description)
  end

end
