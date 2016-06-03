class PossibleResultsController < ApplicationController

  def edit
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
