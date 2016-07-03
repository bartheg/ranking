require 'rails_helper'

RSpec.describe ReportsToCalculateFinderService, type: :service do

  before(:context) do
    @game = create :wesnoth
    @ladder = create :wesnoth_ladder, game: @game
    @blitz_ladder = create :wesnoth_blitz_ladder, game: @game
    @scenario1 = create :freelands, ladder: @ladder
    @scenario2 = create :basilisk, ladder: @ladder
    @scenario1b = create :freelands, ladder: @blitz_ladder
    @scenario2b = create :basilisk, ladder: @blitz_ladder
    @victory = create :victory, game: @game
    @defeat = create :defeat, game: @game
    @draw = create :draw, game: @game
    @userA = create :user_from_china
    @userB = create :user_from_poland
    @userC = create :user_from_china, email: "usa@usa.us", password: "usa23edwjeio23"
    @userD = create :user_from_china, email: "russia@russia.ru", password: "russia23fdweiofj23"
    @userE = create :user_from_china, email: "indoa@india.id", password: "india23edwjeio23"
    @userF = create :user_from_china, email: "germany@germany.ru", password: "germany23fdweiofj23"
    @profileA = create :sun_tzu, user: @userA
    @profileB = create :panther, user: @userB
    @profileC = create :sun_tzu, name: "Patton", user: @userC
    @profileD = create :sun_tzu, name: "Suvorov", user: @userD
    @profileE = create :sun_tzu, name: "Gandhi", user: @userE
    @profileF = create :sun_tzu, name: "Hitler", user: @userF
    @config = create :default_config, is_default: false, ladder: @ladder
  end

  after(:context) do
    LadderConfig.destroy_all
    Profile.destroy_all
    User.destroy_all
    PossibleResult.destroy_all
    Scenario.destroy_all
    Ladder.destroy_all
    Game.destroy_all
  end

  it 'turns status to :to_calculate for the one given report if this report is the only one report for that ladder and the report is :confirmed' do
    one_report = Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB,
      reporters_faction_id: 1, confirmers_faction_id: 2,
      result: @victory, status: :confirmed)
    ladder = one_report.scenario.ladder.reload
    expect do
      ReportsToCalculateFinderService.new(ladder).tag_reports
      one_report.reload
    end.to change{one_report.status}.from('confirmed').to('to_calculate')
  end

  it 'does\'t touch report in other ladder' do
    wrong_ladder_report = Report.create!(scenario: @scenario1b, reporter: @profileA, confirmer: @profileB,
      reporters_faction_id: 1, confirmers_faction_id: 2,
      result: @draw, status: "confirmed")
      @ladder.reload
    expect do
      ReportsToCalculateFinderService.new(@ladder).tag_reports
      wrong_ladder_report.reload
    end.to_not change{wrong_ladder_report.status}
  end

  context "three reports" do

    before(:example) do
      @first_report =  Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :confirmed)
      @second_report = Report.create!(scenario: @scenario1, reporter: @profileC, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :confirmed)
      @third_report =  Report.create!(scenario_id: @scenario1.id, reporter: @profileE, confirmer: @profileF, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :confirmed)
    end

    it 'turns status to :to_calculate for the first confirmed report' do
      ladder = Ladder.find(@first_report.scenario.ladder.id)
      expect do
        ReportsToCalculateFinderService.new(ladder).tag_reports
        @first_report.reload
      end.to change{@first_report.status}.from('confirmed').to('to_calculate')
    end

    it 'turns status to :to_calculate for the second confirmed report' do
      @ladder.reload
      ReportsToCalculateFinderService.new(@ladder).tag_reports
      @second_report.reload
      expect(@second_report.status).to eq 'to_calculate'
    end

    it 'turns status to :to_calculate for the third confirmed report' do
      @ladder.reload
      expect do
        ReportsToCalculateFinderService.new(@ladder).tag_reports
        @third_report.reload
      end.to change(@third_report, :status).from('confirmed').to('to_calculate')
    end

  end


end
