class ReportsController < ApplicationController

  def index
    if params[:ladder_id]
      @ladder = Ladder.find(params[:ladder_id].to_i)
      @header = "Reports of #{@ladder.name}"
      @reports = @ladder.reports

    elsif params[:profile]
      begin
        @profile = Profile.find(params[:profile])
        @header = "Reports for #{@profile.name}"
        @reports = Report.by_profile(@profile)
      rescue ActiveRecord::RecordNotFound
        @header = "Reports for profile ID #{params[:profile]}"
        render :no_profile_error
      end
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

    @report = @report.handle_possible_confirmation

    unless @report.was_just_confirmation?
      if @report.save
        redirect_to reports_path, notice: 'Report was successfully created.'
      else
        render :new
      end
    else
      @report.reload
      ReportsToCalculateFinder.new(@report).tag_to_calculate
      ReportsCalculating.new(@scenario.ladder).calculate
      redirect_to reports_path, notice: 'Report was successfully confirmed.'
    end

  end

  private



  def report_params
    params.require(:report).permit(:scenario_id, :reporter_id, :confirmers_name, :reporters_faction_id, :confirmers_faction_id, :result_id)
  end

end
