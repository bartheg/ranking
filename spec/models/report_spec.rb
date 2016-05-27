require 'rails_helper'

RSpec.describe Report, type: :model do

  describe 'validations' do
    subject { Report.new(scenario_id: 1, reporter_id: 1, confirmer_id: 4,
      reporters_faction_id: 1, confirmers_faction_id: 2,
      result: 1, calculated: false, confirmed: false) }

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    # it 'is invalid without user_id' do
    #   subject.user_id = nil
    #   expect(subject).to be_invalid
    # end
    #
    # it 'is invalid without name' do
    #   subject.name = nil
    #   expect(subject).to be_invalid
    # end
    #
    # it 'is valid when name has only basic letters, numbers "-", "." and "_"' do
    #   subject.name ='ABJxyz0189-._'
    #   expect(subject).to be_valid
    # end
    #
    # it 'is invalid when name has url unfriendly characters' do
    #   subject.name =';s[=_ #]23wesdc'
    #   expect(subject).to be_invalid
    # end
    #
    # it 'is invalid when name has more than 24 characters' do
    #   subject.name ='a' * 25
    #   expect(subject).to be_invalid
    # end
    #
    # it 'is invalid when name has less than 3 characters' do
    #   subject.name ='a' * 2
    #   expect(subject).to be_invalid
    # end
    #
    # it 'is invalid when name has not any letter' do
    #   subject.name ='12_'
    #   expect(subject).to be_invalid
    # end

  end

end
