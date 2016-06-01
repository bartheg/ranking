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

    @report.confirmer = Profile.where(name: report_params[:confirmers_name]).first
    if report_params[:result_description] == 'I lost'
      @report.result = -1
    elsif report_params[:result_description] == 'I won'
      @report.result = 1
    elsif report_params[:result_description] == 'Draw'
      @report.result = 0
    end

    @original_report = @report.original_report
    pry
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
    params.require(:report).permit(:scenario_id, :reporter_id, :confirmers_name, :reporters_faction_id, :confirmers_faction_id, :result_description)
  end

end
