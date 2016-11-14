class RankingConfigsController < ApplicationController



  def new
    @ranking = Ranking.find(params[:ranking_id].to_i)
    @ranking_config = RankingConfig.new
    @ranking_config.ranking = @ranking
  end

  def create
    @ranking = Ranking.find(params[:ranking_id])
    @ranking_config = RankingConfig.new(ranking_config_params)
    @ranking_config.ranking = @ranking
    if @ranking_config.save
      redirect_to @ranking, notice: 'COnfiguration for the ranking was successfully created.'
    else
      render :new
    end
  end



  def edit
    @ranking_config = RankingConfig.find(params[:id])
  end

  def update
    @ranking_config = RankingConfig.find(params[:id])
    if @ranking_config.update_attributes(ranking_config_params)
      if @ranking_config.is_default
        flash[:notice] = "Default ranking config updated successfully."
        redirect_to edit_ranking_config_path(@ranking_config)
      else
        flash[:notice] = "Ranking config updated successfully."
        redirect_to @ranking_config.ranking
      end
    else
      # wtf was that
      # @pages = Page.order('position ASC')
      # @section_count = RankingConfig.count
      render 'edit'
    end
  end

  private

  def ranking_config_params
    params.require(:ranking_config).permit(:default_score, :max_distance_between_players,
      :min_points_to_gain, :disproportion_factor, :unexpected_result_bonus, :hours_to_confirm)
  end

end
