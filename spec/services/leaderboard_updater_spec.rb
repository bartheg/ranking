require 'rails_helper'

RSpec.describe ReportsCalculating, type: :service do

  before(:context) do
    LadderConfig.create!(
      default_ranking: 1300,
      max_distance_between_players: 1000,
      min_points_to_gain: 1,
      disproportion_factor: 10,
      unexpected_result_bonus: 15,
      hours_to_confirm: 49,
      is_default: true
    )
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
  end

  after(:context) do
    Profile.destroy_all
    User.destroy_all
    PossibleResult.destroy_all
    Scenario.destroy_all
    Ladder.destroy_all
    Game.destroy_all
    LadderConfig.destroy_all
  end


  describe ':update' do
    context 'one report, two correct rankings' do

      before :context do
        first_report = Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
        Ranking.create!(profile: @profileA, ladder: @ladder, value: 1350, report: first_report)
        Ranking.create!(profile: @profileB, ladder: @ladder, value: 1250, report: first_report)
      end

      after :context do
        Ranking.destroy_all
        Report.destroy_all
      end

      it 'creates two ranked positions' do
        expect {
          LeaderboardUpdater.update
        }.to change{RankedPosition.count}.from(0).to(2)
      end

    end

  end
  
end
