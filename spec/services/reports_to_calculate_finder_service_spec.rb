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
    @profileA = create :sun_tzu, user: @userA
    @profileB = create :panther, user: @userB
    @profileC = create :sun_tzu, name: "Patton", user: @userC
    @profileD = create :sun_tzu, name: "Suvorov", user: @userD
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
    report = Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB,
      reporters_faction_id: 1, confirmers_faction_id: 2,
      result: @victory, status: :confirmed)
    # wrong_ladder_report = Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB,
    #   reporters_faction_id: 1, confirmers_faction_id: 2,
    #   result: @victory, status: "confirmed")
    expect do
      ReportsToCalculateFinderService.new(@ladder).tag_reports
      report.reload
    end.to change(report, :status).from('confirmed').to('to_calculate')

  end

end
