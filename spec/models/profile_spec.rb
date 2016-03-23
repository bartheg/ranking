require 'rails_helper'

RSpec.describe Profile, type: :model do

  describe 'validations' do
    subject { Profile.new user_id: 1, description: "Some description", color: '#eeddaa'}

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    it 'is invalid without user_id' do
      subject.user_id = nil
      expect(subject).to be_invalid
    end

    it 'is valid without description' do
      subject.description = nil
      expect(subject).to be_valid
    end

    it 'is valid without color' do
      subject.color = nil
      expect(subject).to be_valid
    end

    it 'is valid when in html hex color format' do
      subject.color = '#eEdDaA'
      expect(subject).to be_valid
    end

    it 'is valid when in short html hex color format' do
      subject.color = '#fff'
      expect(subject).to be_valid
    end

    it 'is invalid when not in html hex color format' do
      subject.color = 'eEdDaA'
      expect(subject).to be_invalid
    end

  end

end
