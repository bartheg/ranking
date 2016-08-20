require 'rails_helper'

RSpec.describe ReportsCalculatingService, type: :service do

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
    Ladder.destroy_all
    Game.destroy_all
    LadderConfig.destroy_all
  end

  #private to deleting
  describe '#collect' do

    before(:context) do
      @first_report =  Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
      @second_report = Report.create!(scenario: @scenario2, reporter: @profileC, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :to_calculate)
      @third_report =  Report.create!(scenario_id: @scenario1b.id, reporter: @profileB, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :unconfirmed)
      @fourth_report =  Report.create!(scenario: @scenario2b, reporter: @profileD, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :unconfirmed)
      @fifth_report = Report.create!(scenario: @scenario2, reporter: @profileA, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :unconfirmed)
      @sixth_report =  Report.create!(scenario_id: @scenario2.id, reporter: @profileB, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :to_calculate)
    end

    after(:context) do
      Report.destroy_all
    end

    it 'collect every to_calculate report in to the array' do
      result = ReportsCalculatingService.new(@ladder).collect
      expect(result.map {|r| r.id}).to contain_exactly(@sixth_report.id, @first_report.id, @second_report.id)
    end

    it 'returns empty Relation if no proper reports' do
      result = ReportsCalculatingService.new(@blitz_ladder).collect
      expect(result.map {|r| r.id}).to be_empty
    end

  end

  describe '#calculate_points' do

    context 'input: reporter rank: 234, confirmer rank: 432, result: 20 (reporter 20%, confirmer 80%, so confirmer won)' do
      it 'returns -20' do
        result = ReportsCalculatingService.new(@ladder).calculate_points(234, 432, 20)
        expect(result).to eq -20
      end
    end

    context 'input: reporter rank: -2200, confirmer rank: 700, result: 90 (reporter 90%, confirmer 10%, so reporter won)' do
      it 'returns 524' do
        result = ReportsCalculatingService.new(@ladder).calculate_points(-2200, 700, 90)
        expect(result).to eq 524
      end
    end

  end

  describe '#from_report_to_rankings' do

    it 'returns two rankings' do
      first_report =  Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
      result = ReportsCalculatingService.new(@ladder).from_report_to_rankings(first_report)
      result.map! {|r| r.class}
      expect(result).to eq [Ranking, Ranking]
    end

    it 'returns rankings for reporting and confirming profiles' do
      first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
      result = ReportsCalculatingService.new(@ladder).from_report_to_rankings(first_report)
      result.map! {|r| r.profile}
      expect(result).to eq [@profileB, @profileA]
    end

    it 'returns valid rankings' do
      first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
      result = ReportsCalculatingService.new(@ladder).from_report_to_rankings(first_report)
      result.map! {|r| r.valid?}
      expect(result).to eq [true, true]
    end

    it 'returns rankings for correct ladder' do
      first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
      result = ReportsCalculatingService.new(@ladder).from_report_to_rankings(first_report)
      result.map! {|r| r.ladder}
      expect(result).to eq [@ladder, @ladder]
    end

    context 'unranked profiles' do
      it 'returns rankings with correct values' do
        first_report =  Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
        result = ReportsCalculatingService.new(@ladder).from_report_to_rankings(first_report)
        # default ranking is 1300
        # so it is rank 1300 vs rank 1300, result 100
        # points 50
        result.map! {|r| r.value}
        expect(result).to eq [1350, 1250]
      end
    end
    context 'profiles are ranked' do
      before(:example) do
        report = Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
        Ranking.create!(ladder: @ladder, profile: @profileB, value: 1350, report: report)
        Ranking.create!(ladder: @ladder, profile: @profileA, value: 1250, report: report)
      end

      it 'returns rankings with correct values' do
        second_report = Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
        result = ReportsCalculatingService.new(@ladder).from_report_to_rankings(second_report)
        # it is rank 1350 vs rank 1250, result 100
        # points 45
        result.map! {|r| r.value}
        expect(result).to eq [1395, 1205]
      end
    end

  end

  describe '#calculate' do
  #this is full main method that is doing all job
    context 'one repport only, no rankings' do

      let!(:report) do
        Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :to_calculate)
      end

      it 'creates two rankings' do
        expect {
          ReportsCalculatingService.new(@ladder).calculate
        }.to change{Ranking.count}.by 2
      end

      it 'changes report status from to_calculate to calculated' do
        expect {
          ReportsCalculatingService.new(@ladder).calculate
          report.reload
        }.to change{report.status}.from('to_calculate').to('calculated')
      end

      it 'creates two rankings with reporting and confirming profiles' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        profiles = last_rankings.map {|r| r.profile}
        expect(profiles).to eq [@profileB, @profileA]
      end

      it 'creates two rankings with correct ladder IDs' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        ladders = last_rankings.map {|r| r.ladder}
        expect(ladders).to eq [@ladder, @ladder]
      end

      it 'creates two rankings with correct report IDs' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        reports = last_rankings.map {|r| r.report}
        expect(reports).to eq [report, report]
      end

      it 'creates two rankings with correct values' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        values = last_rankings.map {|r| r.value}
        expect(values).to eq [1350, 1250]
      end

    end

    context 'two reppors, one profile ranked' do

      before(:context) do
        @first_report = Report.create!(scenario: @scenario1, reporter: @profileB, confirmer: @profileA, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
        @first_ranking = Ranking.create!(profile: @profileB, ladder: @ladder, value: 1350, report: @first_report)
        @second_ranking = Ranking.create!(profile: @profileA, ladder: @ladder, value: 1250, report: @first_report)
        @second_report = Report.create!(scenario: @scenario2, reporter: @profileB, confirmer: @profileC, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :to_calculate)
      end

      after(:context) do
        Ranking.destroy_all
        Report.destroy_all
      end

      it 'creates two rankings' do
        expect {
          ReportsCalculatingService.new(@ladder).calculate
        }.to change{Ranking.count}.by 2
      end

      it 'changes report status from to_calculate to calculated' do
        expect {
          ReportsCalculatingService.new(@ladder).calculate
          @second_report.reload
        }.to change{@second_report.status}.from('to_calculate').to('calculated')
      end

      it 'creates two rankings with reporting and confirming profiles' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        profiles = last_rankings.map {|ranking| ranking.profile}
        expect(profiles).to eq [@profileB, @profileC]
      end

      it 'creates two rankings with correct ladder IDs' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        ladders = last_rankings.map {|ranking| ranking.ladder}
        expect(ladders).to eq [@ladder, @ladder]
      end

      it 'creates two rankings with correct report IDs' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        reports = last_rankings.map {|r| r.report}
        expect(reports).to eq [@second_report, @second_report]
      end

      it 'creates two rankings with correct values' do
        ReportsCalculatingService.new(@ladder).calculate
        last_rankings = Ranking.last 2
        values = last_rankings.map {|r| r.value}
        expect(values).to eq [1289, 1361]
      end

    end


  end

end
