require 'rails_helper'

RSpec.describe CalculatedPosition, type: :model do

  before(:context) do
    create :default_config, default_score: 1400
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

  describe ':find_score' do
    before(:context) do
      CalculatedPosition.create!(report_id: 1, value: 3232, profile_id: @profileA.id, ranking_id: @ranking.id)
      CalculatedPosition.create!(report_id: 1, value: 232, profile_id: @profileB.id, ranking_id: @ranking.id)
      CalculatedPosition.create!(report_id: 2, value: 2000, profile_id: @profileA.id, ranking_id: @blitz_ranking.id)
      CalculatedPosition.create!(report_id: 2, value: 500, profile_id: @profileB.id, ranking_id: @blitz_ranking.id)
    end

    after(:context) do
      CalculatedPosition.destroy_all
      RankedPosition.destroy_all
    end

    it 'returns a score value of given profile in given ranking' do
      expect(CalculatedPosition.find_score(@ranking, @profileB)).to eq 232
    end

    it 'returns a score value of given profile in given ranking 2' do
      CalculatedPosition.create!(report_id: 3, value: 1800, profile_id: @profileA.id, ranking_id: @blitz_ranking.id)
      CalculatedPosition.create!(report_id: 3, value: 400, profile_id: @profileB.id, ranking_id: @blitz_ranking.id)
      expect(CalculatedPosition.find_score(@blitz_ranking, @profileA)).to eq 1800
    end

    context 'when profile has no calculated_position in given ranking' do
      it 'returns the default calculated_position' do
        expect(CalculatedPosition.find_score(@blitz_ranking, @profileC)).to eq 1400
      end
    end

  end

  # describe ':create' do
  #   context 'when no calculated_positions yet' do
  #     it 'creates two ranked positions' do
  #     report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profileA.id, confirmer_id: @profileB.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "calculated")
  #
  #     expect {
  #       CalculatedPosition.create!(report_id: report.id, value: 1450, profile_id: @profileA.id, ranking_id: @ranking.id)
  #       CalculatedPosition.create!(report_id: report.id, value: 1350, profile_id: @profileB.id, ranking_id: @ranking.id)
  #     }.to change{RankedPosition.count}.from(0).to(2)
  #     end
  #
  #   end
  #
  #
  #
  # end


end
