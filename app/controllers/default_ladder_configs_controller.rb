class DefaultLadderConfigsController < ApplicationController

  def edit
    @default_ladder_config = DefaultLadderConfig.find(params[:id])
  end

  def update
    @default_ladder_config = DefaultLadderConfig.find(params[:id])
    if @default_ladder_config.update_attributes(default_ladder_config_params)
      flash[:notice] = "Default ladder config updated successfully."
      redirect_to edit_default_ladder_config_path(@default_ladder_config)
    else
      @pages = Page.order('position ASC')
      @section_count = DefaultLadderConfig.count
      render 'edit'
    end
  end

  private

  def default_ladder_config_params
    params.require(:default_ladder_config).permit(:default_ranking, :max_distance_between_players,
      :min_points_to_gain, :disproportion_factor, :unexpected_result_bonus, :hours_to_confirm)
  end

end
