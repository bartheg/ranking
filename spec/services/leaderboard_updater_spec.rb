require 'rails_helper'

RSpec.describe ReportsCalculating, type: :service do

  before(:context) do
    RankingConfig.create!(
      default_score: 1300,
      max_distance_between_players: 1000,
      min_points_to_gain: 1,
      disproportion_factor: 10,
      unexpected_result_bonus: 15,
      hours_to_confirm: 49,
      is_default: true
    )
    @game = create :wesnoth
    @ranking = create :wesnoth_ranking, game: @game
    @blitz_ranking = create :wesnoth_blitz_ranking, game: @game
    @scenario1 = create :freelands, ranking: @ranking
    @scenario2 = create :basilisk, ranking: @ranking
    @scenario1b = create :freelands, ranking: @blitz_ranking
    @scenario2b = create :basilisk, ranking: @blitz_ranking
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
    Ranking.destroy_all
    Game.destroy_all
    RankingConfig.destroy_all
  end


  describe ':update' do
    context 'one report, two correct calculated_positions' do

      before :context do
        first_report = Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
        CalculatedPosition.create!(profile: @profileA, ranking: @ranking, value: 1350, report: first_report)
        CalculatedPosition.create!(profile: @profileB, ranking: @ranking, value: 1250, report: first_report)
      end

      after :context do
        CalculatedPosition.destroy_all
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

      it 'creates two ranked positions with correct ranking' do
        LeaderboardUpdater.update
        ranked_positions = RankedPosition.all
        rankings = ranked_positions.map {|p| p.ranking}
        expect(rankings).to match_array [@ranking, @ranking]
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
                                 rp.ranking,
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
          [@profileA, @ranking, 1350, 50, @profileA.calculated_positions.last.report.created_at, 1, 1, 50, 50],
          [@profileB, @ranking, 1250, -50, @profileB.calculated_positions.last.report.created_at, 1, 0, 0, 0]
        ]
      end

      context "one more report and two additional calculated_positions" do
        before :context do
          LeaderboardUpdater.update
          second_report = Report.create!(scenario: @scenario2, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :calculated)
          CalculatedPosition.create!(profile: @profileA, ranking: @ranking, value: 1280, report: second_report)
          CalculatedPosition.create!(profile: @profileB, ranking: @ranking, value: 1320, report: second_report)
        end

        after :context do
          RankedPosition.destroy_all
          CalculatedPosition.destroy_all
          Report.destroy_all
        end

        it 'still has old ranked positions before update' do
          ranked_positions = RankedPosition.all
          actual_attributes = []
          ranked_positions.each do |rp|
            actual_attributes << [ rp.profile,
                                   rp.ranking,
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
            [@profileA, @ranking, 1350, 50, @profileA.calculated_positions.first.report.created_at, 1, 1, 50, 50],
            [@profileB, @ranking, 1250, -50, @profileB.calculated_positions.first.report.created_at, 1, 0, 0, 0]
          ]
        end

        it "doesn't create new ranked positions" do
          expect { LeaderboardUpdater.update }.to_not change{RankedPosition.count}
        end

        it 'updates old ranked positions with correct profile and current_score' do
          LeaderboardUpdater.update
          ranked_positions = RankedPosition.all
          actual_attributes = []
          ranked_positions.each do |rp|
            actual_attributes << [ rp.profile,
                                   rp.current_score,
                                  ]
          end
          expect(actual_attributes).to match_array [
            [@profileA, 1280],
            [@profileB, 1320]
          ]
        end

        it 'updates old ranked positions with correct profile and last_score_gained' do
          LeaderboardUpdater.update
          ranked_positions = RankedPosition.all
          actual_attributes = []
          ranked_positions.each do |rp|
            actual_attributes << [ rp.profile,
                                   rp.last_score_gained,
                                  ]
          end
          expect(actual_attributes).to match_array [
            [@profileA, -70],
            [@profileB, 70]
          ]
        end

        it 'updates old ranked positions with correct profile and ranking' do
          LeaderboardUpdater.update
          ranked_positions = RankedPosition.all
          actual_attributes = []
          ranked_positions.each do |rp|
            actual_attributes << [ rp.profile,
                                   rp.ranking,
                                  ]
          end
          expect(actual_attributes).to match_array [
            [@profileA, @ranking],
            [@profileB, @ranking]
          ]
        end

        it 'updates old ranked positions with correct profile and last_match_at' do
          LeaderboardUpdater.update
          ranked_positions = RankedPosition.all
          actual_attributes = []
          ranked_positions.each do |rp|
            actual_attributes << [ rp.profile,
                                   rp.last_match_at,
                                  ]
          end
          expect(actual_attributes).to match_array [
            [@profileA, @profileA.calculated_positions.last.report.created_at],
            [@profileB, @profileB.calculated_positions.last.report.created_at]
          ]
        end

        it 'updates old ranked positions with correct profile and number_of_confirmed_matches' do
          LeaderboardUpdater.update
          ranked_positions = RankedPosition.all
          actual_attributes = []
          ranked_positions.each do |rp|
            actual_attributes << [ rp.profile,
                                   rp.number_of_confirmed_matches,
                                  ]
          end
          expect(actual_attributes).to match_array [
            [@profileA, 2],
            [@profileB, 2]
          ]
        end

        it 'updates old ranked positions with correct profile and number_of_won_matches' do
          LeaderboardUpdater.update
          ranked_positions = RankedPosition.all
          actual_attributes = []
          ranked_positions.each do |rp|
            actual_attributes << [ rp.profile,
                                   rp.number_of_won_matches,
                                  ]
          end
          expect(actual_attributes).to match_array [
            [@profileA, 1],
            [@profileB, 1]
          ]
        end

        context "one more report and two additional calculated_positions but with a player in this ranking" do
          before :context do
            LeaderboardUpdater.update
            third_report = Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
            CalculatedPosition.create!(profile: @profileA, ranking: @ranking, value: 1334, report: third_report)
            CalculatedPosition.create!(profile: @profileC, ranking: @ranking, value: 1246, report: third_report)
          end

          after :context do
            RankedPosition.destroy_all
            CalculatedPosition.destroy_all
            Report.destroy_all
          end

          it 'still has old ranked positions before update' do
            ranked_positions = RankedPosition.all
            actual_attributes = []
            ranked_positions.each do |rp|
              actual_attributes << [ rp.profile,
                                     rp.ranking,
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
              [@profileA, @ranking, 1280, -70, @profileA.calculated_positions.second.report.created_at, 2, 1, 50, 50],
              [@profileB, @ranking, 1320, 70, @profileB.calculated_positions.second.report.created_at, 2, 1, 70, 70]
            ]
          end

          it "creates one new ranked positions" do
            expect { LeaderboardUpdater.update }.to change{RankedPosition.count}.from(2).to(3)
          end

          it 'updates two old ranked positions and creates one new with correct
              profile, ranking, current_score, and last_score_gaines' do
            LeaderboardUpdater.update
            ranked_positions = RankedPosition.all
            actual_attributes = []
            ranked_positions.each do |rp|
              actual_attributes << [ rp.profile.id,
                                     rp.ranking.id,
                                     rp.current_score,
                                     rp.last_score_gained
                                    ]
            end
            expect(actual_attributes).to match_array [
              [@profileA.id, @ranking.id, 1334, 54],
              [@profileB.id, @ranking.id, 1320, 70],
              [@profileC.id, @ranking.id, 1246, -54]
            ]
          end

          it 'updates two old ranked positions and creates one new with correct
              profile, last_match_at, number_of_confirmed_matches,
              number_of_won_matches, scores_from_wins, average_win_score' do
            LeaderboardUpdater.update
            ranked_positions = RankedPosition.all
            actual_attributes = []
            ranked_positions.each do |rp|
              actual_attributes << [ rp.profile.id,
                                      rp.last_match_at,
                                      rp.number_of_confirmed_matches,
                                      rp.number_of_won_matches,
                                      rp.scores_from_wins,
                                      rp.average_win_score
                                    ]
            end
            expect(actual_attributes).to match_array [
              [@profileA.id, @profileA.calculated_positions.last.report.created_at, 3, 2, 104, 52],
              [@profileB.id, @profileB.calculated_positions.last.report.created_at, 2, 1, 70, 70],
              [@profileC.id, @profileC.calculated_positions.last.report.created_at, 1, 0, 0, 0]
            ]
          end

        end


      end

    end

  end

end
