class LaddersController < ApplicationController

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

  def new
    @ladder = Ladder.new
  end

  def create
    @ladder = Ladder.new(ladder_params)
    if @ladder.save
      redirect_to @ladder, notice: 'Ladder was successfully created.'
    else
      render :new
    end
  end

  private

  def ladder_params
    params.require(:ladder).permit(:name, :description, :game_id)
  end

end
