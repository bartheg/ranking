require 'rails_helper'

RSpec.describe Language, type: :model do

  describe 'validations' do
    subject { Language.new iso_639_1: "et", english_name: "Estonian"}

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    it 'is invalid without iso_639_1' do
      subject.iso_639_1 = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without english_name' do
      subject.english_name = nil
      expect(subject).to be_invalid
    end

    it 'is invalid when iso_639_1 is not a two lower case letters' do
      subject.iso_639_1 = 'Sa'
      expect(subject).to be_invalid
    end

    it 'is invalid when iso_639_1 is not a two lower case letters' do
      subject.iso_639_1 = 'saa'
      expect(subject).to be_invalid
    end

    it 'is invalid when the first letter of english_name is not a upper case' do
      subject.english_name = 'english'
      expect(subject).to be_invalid
    end


    # it 'is valid without color' do
    #   subject.color = nil
    #   expect(subject).to be_valid
    # end
    #
    # it 'is valid when in html hex color format' do
    #   subject.color = '#eEdDaA'
    #   expect(subject).to be_valid
    # end
    #
    #
    # it 'is invalid when not in html hex color format' do
    #   subject.color = 'eEdDaA'
    #   expect(subject).to be_invalid
    # end

  end

end
