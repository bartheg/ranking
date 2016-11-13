class ReportsController < ApplicationController

  def index
    if params[:ranking_id]
      @ranking = Ranking.find(params[:ranking_id].to_i)
      @header = "Reports of #{@ranking.name}"
      @reports = @ranking.reports

    elsif params[:profile]
      begin
        @profile = Profile.find(params[:profile])
        @header = "Reports for #{@profile.name}"
        @reports = Report.by_profile(@profile)
      rescue ActiveRecord::RecordNotFound
        @header = "Reports for profile ID #{params[:profile]}"
        render :no_profile_error
      end
    elsif params[:user_id]
      user = User.find(params[:user_id])
      @reports = Report.where(["reporter_id = ? OR confirmer_id = ?", user.profiles.pluck(:id), user.profiles.pluck(:id)])

    else
      @header = "Reports"
      @reports = Report.all

    end
  end

  def confirm
    report = Report.find(params[:id])
    report.confirm
    ReportsToCalculateFinder.new(report).tag_to_calculate
    ReportsCalculating.new(report.scenario.ranking).calculate
    LeaderboardUpdater.update
    redirect_to user_reports_path(params[:user_id]), notice: 'Report was successfully confirmed.'
  end

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
      ReportsCalculating.new(@scenario.ranking).calculate
      LeaderboardUpdater.update
      redirect_to reports_path, notice: 'Report was successfully confirmed.'
    end

  end

  private



  def report_params
    params.require(:report).permit(:scenario_id, :reporter_id, :confirmers_name, :reporters_faction_id, :confirmers_faction_id, :result_id)
  end

end
