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
      @scenario = Scenario.find(params[:scenario_id])
      @report.scenario_id = params[:scenario_id]
    end
    @report.reporter = current_user.current_profile
  end

  def create
    @report = Report.new(report_params)
    @scenario = Scenario.find(report_params[:scenario_id])

    @report.confirmer = Profile.where(name: report_params[:confirmers_name]).first

    @original_report = @report.original_report

    if @original_report
      @original_report.confirmed = true
      if @original_report.save
        redirect_to reports_path, notice: 'Report was successfully confirmed.'
      else
        render :new
      end
    else
      @report.confirmed = false
      @report.calculated = false
      if @report.save
        redirect_to reports_path, notice: 'Report was successfully created.'
      else
        render :new
      end
    end


  end

  private

  def report_params
    params.require(:report).permit(:scenario_id, :reporter_id, :confirmers_name, :reporters_faction_id, :confirmers_faction_id, :result_id)
  end

end
