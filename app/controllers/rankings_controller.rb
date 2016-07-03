class RankingsController < ApplicationController

  def index
    if params[:ladder_id]
      @ladder = Ladder.find(params[:ladder_id].to_i)
      @header = "Rankings of #{@ladder.name}"
      @rankings = @ladder.rankings

    else
      @header = "Rankings"
      @rankings = Ranking.all
    end
  end

end
