require 'rails_helper'

RSpec.describe RankingConfig, type: :model do

  describe 'validations' do

    before(:context) do
      create(:default_config)
      @ranking = Ranking.create!(name: "Super Bowl", description: "Abracadabra.", game_id: 1)
    end

    after(:context) do
      Ranking.destroy_all
      RankingConfig.destroy_all
    end

    subject { RankingConfig.new(
      default_score: 1500,
      max_distance_between_players: 10,
      min_points_to_gain: 5,
      disproportion_factor: 50,
      unexpected_result_bonus: 50,
      hours_to_confirm: 48,
      is_default: false,
      ranking_id: @ranking.id)
    }

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    it 'is invalid without default_score' do
      subject.default_score = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without hours_to_confirm' do
      subject.hours_to_confirm = nil
      expect(subject).to be_invalid
    end

    it 'is valid when is_default is not set' do
      config = RankingConfig.new(
       default_score: 1500,
       max_distance_between_players: 10,
       min_points_to_gain: 5,
       disproportion_factor: 50,
       unexpected_result_bonus: 50,
       hours_to_confirm: 48,
       ranking_id: @ranking.id)
      expect(config).to be_valid
    end

    it 'is invalid when is_default is true and ranking_id is not nil' do
      subject.is_default = true
      subject.ranking_id = @ranking.id
      expect(subject).to be_invalid
    end

    it 'is invalid when is_default is false and ranking_id is nil' do
      subject.is_default = false
      subject.ranking_id = nil
      expect(subject).to be_invalid
    end

    it 'is invalid when ranking is not in the base' do
      @not_existing_ranking = Ranking.create!(name: "Useless", description: "I will be deleted.", game_id: 1)
      subject.is_default = false
      subject.ranking_id = @not_existing_ranking.id
      @not_existing_ranking.destroy
      expect(subject).to be_invalid
    end


  end

  describe 'default_config' do
    it 'returns the default configuration' do
      default_conf = create(:default_config)
      ranking = Ranking.create!(name: "Super Bowl", description: "Abracadabra.", game_id: 1)
      expect(RankingConfig.default_config).to eql default_conf

    end
  end

end
