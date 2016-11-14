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
    @userE = create :user_from_china, email: "indoa@india.id", password: "india23edwjeio23"
    @userF = create :user_from_china, email: "germany@germany.ru", password: "germany23fdweiofj23"
    @profileA = create :sun_tzu, user: @userA
    @profileB = create :panther, user: @userB
    @profileC = create :sun_tzu, name: "Patton", user: @userC
    @profileD = create :sun_tzu, name: "Suvorov", user: @userD
    @profileE = create :sun_tzu, name: "Gandhi", user: @userE
    @profileF = create :sun_tzu, name: "Hitler", user: @userF
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

  #private to deleting
  # describe '#collect' do
  #
  #   before(:context) do
  #     @first_report =  Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
  #     @second_report = Report.create!(scenario: @scenario2, reporter: @profileC, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :to_calculate)
  #     @third_report =  Report.create!(scenario_id: @scenario1b.id, reporter: @profileB, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :unconfirmed)
  #     @fourth_report =  Report.create!(scenario: @scenario2b, reporter: @profileD, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :unconfirmed)
  #     @fifth_report = Report.create!(scenario: @scenario2, reporter: @profileA, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :unconfirmed)
  #     @sixth_report =  Report.create!(scenario_id: @scenario2.id, reporter: @profileB, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :to_calculate)
  #   end
  #
  #   after(:context) do
  #     Report.destroy_all
  #   end
  #
  #   it 'collect every to_calculate report in to the array' do
  #     result = ReportsCalculating.new(@ranking).collect
  #     expect(result.map {|r| r.id}).to contain_exactly(@sixth_report.id, @first_report.id, @second_report.id)
  #   end
  #
  #   it 'returns empty Relation if no proper reports' do
  #     result = ReportsCalculating.new(@blitz_ranking).collect
  #     expect(result.map {|r| r.id}).to be_empty
  #   end
  #
  # end
  #
  # describe '#calculate_points' do
  #
  #   context 'input: reporter rank: 234, confirmer rank: 432, result: 20 (reporter 20%, confirmer 80%, so confirmer won)' do
  #     it 'returns -20' do
  #       result = ReportsCalculating.new(@ranking).calculate_points(234, 432, 20)
  #       expect(result).to eq -20
  #     end
  #   end
  #
  #   context 'input: reporter rank: -2200, confirmer rank: 700, result: 90 (reporter 90%, confirmer 10%, so reporter won)' do
  #     it 'returns 524' do
  #       result = ReportsCalculating.new(@ranking).calculate_points(-2200, 700, 90)
  #       expect(result).to eq 524
  #     end
  #   end
  #
  # end
  #
  # describe '#from_report_to_calculated_positions' do
  #
  #   it 'returns two calculated_positions' do
  #     first_report =  Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
  #     result = ReportsCalculating.new(@ranking).from_report_to_calculated_positions(first_report)
  #     result.map! {|r| r.class}
  #     expect(result).to eq [CalculatedPosition, CalculatedPosition]
  #   end
  #
  #   it 'returns calculated_positions for reporting and confirming profiles' do
  #     first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
  #     result = ReportsCalculating.new(@ranking).from_report_to_calculated_positions(first_report)
  #     result.map! {|r| r.profile}
  #     expect(result).to eq [@profileB, @profileA]
  #   end
  #
  #   it 'returns valid calculated_positions' do
  #     first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
  #     result = ReportsCalculating.new(@ranking).from_report_to_calculated_positions(first_report)
  #     result.map! {|r| r.valid?}
  #     expect(result).to eq [true, true]
  #   end
  #
  #   it 'returns calculated_positions for correct ranking' do
  #     first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
  #     result = ReportsCalculating.new(@ranking).from_report_to_calculated_positions(first_report)
  #     result.map! {|r| r.ranking}
  #     expect(result).to eq [@ranking, @ranking]
  #   end
  #
  #   context 'unranked profiles' do
  #     it 'returns calculated_positions with correct values' do
  #       first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
  #       result = ReportsCalculating.new(@ranking).from_report_to_calculated_positions(first_report)
  #       # default calculated_position is 1300
  #       # so it is rank 1300 vs rank 1300, result 100
  #       # points 50
  #       result.map! {|r| r.value}
  #       expect(result).to eq [1350, 1250]
  #     end
  #   end
  #   context 'profiles are ranked' do
  #     before(:example) do
  #       report = Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
  #       CalculatedPosition.create!(ranking: @ranking, profile: @profileB, value: 1350, report: report)
  #       CalculatedPosition.create!(ranking: @ranking, profile: @profileA, value: 1250, report: report)
  #     end
  #
  #     it 'returns calculated_positions with correct values' do
  #       second_report = Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
  #       result = ReportsCalculating.new(@ranking).from_report_to_calculated_positions(second_report)
  #       # it is rank 1350 vs rank 1250, result 100
  #       # points 45
  #       result.map! {|r| r.value}
  #       expect(result).to eq [1395, 1205]
  #     end
  #   end
  #
  # end

  describe '#calculate' do
  #this is full main method that is doing all job
    context 'one repport only, no calculated_positions' do

      let!(:report) do
        Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
      end

      it 'creates two calculated_positions' do
        expect {
          ReportsCalculating.new(@ranking).calculate
        }.to change{CalculatedPosition.count}.by 2
      end

      it 'changes report status from to_calculate to calculated' do
        expect {
          ReportsCalculating.new(@ranking).calculate
          report.reload
        }.to change{report.status}.from('to_calculate').to('calculated')
      end

      it 'creates two calculated_positions with reporting and confirming profiles' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        profiles = last_calculated_positions.map {|r| r.profile}
        expect(profiles).to eq [@profileB, @profileA]
      end

      it 'creates two calculated_positions with correct ranking IDs' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        rankings = last_calculated_positions.map {|r| r.ranking}
        expect(rankings).to eq [@ranking, @ranking]
      end

      it 'creates two calculated_positions with correct report IDs' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        reports = last_calculated_positions.map {|r| r.report}
        expect(reports).to eq [report, report]
      end

      it 'creates two calculated_positions with correct values' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        values = last_calculated_positions.map {|r| r.value}
        expect(values).to eq [1350, 1250]
      end

    end

    context 'two reppors, one profile ranked' do

      before(:context) do
        @first_report = Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
        @first_calculated_position = CalculatedPosition.create!(profile: @profileB, ranking: @ranking, value: 1350, report: @first_report)
        @second_calculated_position = CalculatedPosition.create!(profile: @profileA, ranking: @ranking, value: 1250, report: @first_report)
        @second_report = Report.create!(scenario: @scenario2, reporter: @profileB, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :to_calculate)
      end

      after(:context) do
        CalculatedPosition.destroy_all
        Report.destroy_all
      end

      it 'creates two calculated_positions' do
        expect {
          ReportsCalculating.new(@ranking).calculate
        }.to change{CalculatedPosition.count}.by 2
      end

      it 'changes report status from to_calculate to calculated' do
        expect {
          ReportsCalculating.new(@ranking).calculate
          @second_report.reload
        }.to change{@second_report.status}.from('to_calculate').to('calculated')
      end

      it 'creates two calculated_positions with reporting and confirming profiles' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        profiles = last_calculated_positions.map {|calculated_position| calculated_position.profile}
        expect(profiles).to eq [@profileB, @profileC]
      end

      it 'creates two calculated_positions with correct ranking IDs' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        rankings = last_calculated_positions.map {|calculated_position| calculated_position.ranking}
        expect(rankings).to eq [@ranking, @ranking]
      end

      it 'creates two calculated_positions with correct report IDs' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        reports = last_calculated_positions.map {|r| r.report}
        expect(reports).to eq [@second_report, @second_report]
      end

      it 'creates two calculated_positions with correct values' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 2
        values = last_calculated_positions.map {|r| r.value}
        expect(values).to eq [1289, 1361]
      end

    end


    context 'two calculated reppors with calculated_positions, three reports to calculate' do

      before(:context) do
        @first_report = Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
        @first_calculated_position = CalculatedPosition.create!(profile: @profileB, ranking: @ranking, value: 1350, report: @first_report)
        @second_calculated_position = CalculatedPosition.create!(profile: @profileA, ranking: @ranking, value: 1250, report: @first_report)
        @second_report = Report.create!(scenario: @scenario2, reporter: @profileB, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :calculated)
        @third_calculated_position = CalculatedPosition.create!(profile: @profileB, ranking: @ranking, value: 1289, report: @second_report)
        @fourth_calculated_position = CalculatedPosition.create!(profile: @profileC, ranking: @ranking, value: 1361, report: @second_report)
        @third_report = Report.create!(scenario: @scenario2, reporter: @profileC, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :to_calculate)
        @fourth_report = Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :to_calculate)
        @fifth_report = Report.create!(scenario: @scenario2, reporter: @profileE, confirmer: @profileF, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :to_calculate)

      end

      after(:context) do
        CalculatedPosition.destroy_all
        Report.destroy_all
      end

      it 'creates six calculated_positions' do
        expect {
          ReportsCalculating.new(@ranking).calculate
        }.to change{CalculatedPosition.count}.by 6
      end

      it 'changes report status from to_calculate to calculated' do
        expect {
          ReportsCalculating.new(@ranking).calculate
        }.to change{Report.last(3).map {|report| report.status}}
        .from(['to_calculate', 'to_calculate', 'to_calculate'])
        .to(['calculated', 'calculated','calculated'])
      end

      it 'creates six calculated_positions with reporting and confirming profiles' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 6
        profiles = last_calculated_positions.map {|calculated_position| calculated_position.profile}
        expect(profiles).to eq [@profileC, @profileD, @profileA, @profileD, @profileE, @profileF]
      end

      it 'creates six calculated_positions with correct ranking IDs' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 6
        rankings = last_calculated_positions.map {|calculated_position| calculated_position.ranking}
        expect(rankings).to eq [@ranking, @ranking, @ranking, @ranking, @ranking, @ranking]
      end

      it 'creates six calculated_positions with correct report IDs' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 6
        reports = last_calculated_positions.map {|r| r.report}
        expect(reports).to eq [@third_report, @third_report, @fourth_report, @fourth_report, @fifth_report, @fifth_report]
      end

      it 'creates six calculated_positions with correct values' do
        ReportsCalculating.new(@ranking).calculate
        last_calculated_positions = CalculatedPosition.last 6
        values = last_calculated_positions.map {|r| r.value}
        expect(values).to eq [1358, 1303, 1203, 1350, 1300, 1300]
      end

    end


  end

end
