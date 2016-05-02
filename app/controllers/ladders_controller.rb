class LaddersController < ApplicationController

  def index
    @ladders = Ladder.all
  end

end
