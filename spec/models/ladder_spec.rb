require 'rails_helper'

RSpec.describe Ladder, type: :model do

  describe 'validations' do
    subject { Ladder.new(name: "Weslol", description: "Ladder for lols Wesnoth", game_id: 1)}

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without a description' do
      subject.description = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without a game_id' do
      subject.game_id = nil
      expect(subject).to be_invalid
    end

  end

  context 'after save' do

    subject { Ladder.create!(name: "Weslol", description: "Ladder for lols Wesnoth", game_id: 1)}

    before(:context) do
      @config = create :default_config, min_points_to_gain: 111
    end

    after(:context) do
      LadderConfig.destroy_all
    end

    it 'create a ladder config' do
      expect { subject.save }.to change{LadderConfig.count}.by(1)
    end

    it 'create a ladder config identical min_points_to_gain as default config' do
      config = LadderConfig.where(ladder_id: subject.id).first
      expect(config.min_points_to_gain).to eq 111
    end

  end

end
