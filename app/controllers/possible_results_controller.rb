class PossibleResultsController < ApplicationController

  def new
    @game = Game.find(params[:game_id].to_i)
    @possible_result = PossibleResult.new
    @possible_result.game = @game
  end

  def create
    @game = Game.find(params[:game_id])
    @possible_result = PossibleResult.new(possible_result_params)
    @possible_result.game = @game
    if @possible_result.save
      redirect_to @game, notice: 'Possible result was successfully created.'
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:game_id])
    @possible_result = PossibleResult.find(params[:id])
  end

  def update
    @possible_result = PossibleResult.find(params[:id])
    if @possible_result.update_attributes(possible_result_params)
      flash[:notice] = "Possible result updated successfully."
      redirect_to @possible_result.game
    else
      @pages = Page.order('position ASC')
      @section_count = PossibleResult.count
      render 'edit'
    end
  end

  private

  def possible_result_params
    params.require(:possible_result).permit(:description, :score_factor)
  end

end
