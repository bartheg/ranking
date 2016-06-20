class LadderConfigsController < ApplicationController

  def edit
    @ladder_config = LadderConfig.find(params[:id])
  end

  def update
    @ladder_config = LadderConfig.find(params[:id])
    if @ladder_config.update_attributes(ladder_config_params)
      flash[:notice] = "Default ladder config updated successfully."
      redirect_to edit_ladder_config_path(@ladder_config)
    else
      @pages = Page.order('position ASC')
      @section_count = LadderConfig.count
      render 'edit'
    end
  end

  private

  def ladder_config_params
    params.require(:ladder_config).permit(:default_ranking, :max_distance_between_players,
      :min_points_to_gain, :disproportion_factor, :unexpected_result_bonus, :hours_to_confirm)
  end

end
