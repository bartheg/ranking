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

  end

end
