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
    @report.reporter = current_user.current_profile
  end

  def create
    @report = Report.new(report_params)

    @report.opponent = Profile.where(name: report_params[:opponents_name]).first
    if report_params[:result_description] = 'I lost'
      @report.result = -1
    elsif report_params = 'I won'
      @report.result = 1
    elsif report_params = 'Draw'
      @report.result = 0
    end

# todo rest of parameters
    if @report.save
      redirect_to reports_path, notice: 'Report was successfully created.'
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:scenario_id, :reporter_id, :opponents_name, :reporters_faction_id, :opponents_faction_id, :result_description, :message)
  end

end
