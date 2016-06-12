require 'rails_helper'

RSpec.describe DefaultLadderConfig, type: :model do

  describe 'validations' do

    subject { DefaultLadderConfig.new(
      default_ranking: 1500,
      loot_factor: 10,
      loot_constant: 5,
      disproportion_factor: 50,
      draw_factor: 50,
      hours_to_confirm: 48,
      is_default: false,
      ladder_id: 1)
    }

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    it 'is invalid without default_ranking' do
      subject.default_ranking = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without hours_to_confirm' do
      subject.hours_to_confirm = nil
      expect(subject).to be_invalid
    end

    it 'is valid when is_default is not set' do
      config = DefaultLadderConfig.new(
       default_ranking: 1500,
       loot_factor: 10,
       loot_constant: 5,
       disproportion_factor: 50,
       draw_factor: 50,
       hours_to_confirm: 48,
       ladder_id: 1)
      expect(config).to be_valid
    end

    it 'is invalid when is_default is true and ladder_id is not nil' do
      subject.is_default = true
      subject.ladder_id = 1
      expect(subject).to be_invalid
    end

    it 'is invalid when is_default is false and ladder_id is nil' do
      subject.is_default = false
      subject.ladder_id = nil
      expect(subject).to be_invalid
    end


  end

end
