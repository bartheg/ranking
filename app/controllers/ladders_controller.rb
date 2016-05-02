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

end
