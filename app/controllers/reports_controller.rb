class ReportsController < ApplicationController

  def index
    if params[:ladder_id]
      @ladder = Ladder.find(params[:ladder_id].to_i)
      @header = "Reports of #{@ladder.name}"
      @reports = @ladder.reports

    else
      @header = "Reports"
      @reports = Report.all
    end
  end

### copyed

  def new
    @report = Report.new
    if params[:scenario_id]
      @report.scenario_id = params[:scenario_id]
    end
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to @report, notice: 'Report was successfully created.'
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:name, :description, :color, language_ids: [])
  end

end
