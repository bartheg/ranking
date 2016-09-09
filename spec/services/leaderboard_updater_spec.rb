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

      it 'creates two ranked positions with correct profiles' do
        LeaderboardUpdater.update
        ranked_positions = RankedPosition.all
        profiles = ranked_positions.map {|p| p.profile}
        expect(profiles).to match_array [@profileA, @profileB]
      end

      it 'creates two ranked positions with correct scores' do
        LeaderboardUpdater.update
        ranked_positions = RankedPosition.all
        scores = ranked_positions.map {|p| p.current_score}
        expect(scores).to match_array [1350, 1250]
      end

      it 'creates two ranked positions with correct ladder' do
        LeaderboardUpdater.update
        ranked_positions = RankedPosition.all
        ladders = ranked_positions.map {|p| p.ladder}
        expect(ladders).to match_array [@ladder, @ladder]
      end

      it 'creates two ranked positions with correct last_score_gained' do
        LeaderboardUpdater.update
        ranked_positions = RankedPosition.all
        changes = ranked_positions.map {|p| p.last_score_gained}
        expect(changes).to match_array [-50, 50]
      end

      it 'creates two ranked positions with correct attributes' do
        LeaderboardUpdater.update
        ranked_positions = RankedPosition.all
        actual_attributes = []
        ranked_positions.each do |rp|
          actual_attributes << [ rp.profile,
                                 rp.ladder,
                                 rp.current_score,
                                 rp.last_score_gained,
                                 rp.last_match_at,
                                 rp.number_of_confirmed_matches,
                                 rp.number_of_won_matches,
                                 rp.scores_from_wins,
                                 rp.average_win_score
                                ]
        end
        expect(actual_attributes).to match_array [
          [@profileA, @ladder, 1350, 50, @profileA.rankings.last.report.created_at, 1, 1, 50, 50],
          [@profileB, @ladder, 1250, -50, @profileB.rankings.last.report.created_at, 1, 0, 0, 0]
        ]
      end

    end

  end

end
