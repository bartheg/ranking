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

  describe '#save' do

    it 'changes the default profile of the user to itself if it is the only pfofile of the user' do
      user = User.create(email:"qweasd@qwe.pl", password:'asdqwe123123')
      profile = Profile.create user_id: user.id, description: "Some description", color: '#eeddaa'

      expect(user.reload.default_profile.id).to eq profile.id
    end

    it 'doesnt change default_profile when there is one' do
      user1 = User.create(email:"qweasd@qwe.pl", password:'asdqwe123123')
      profile1 = Profile.create user_id: user1.id, description: "Some description", color: '#eeddaa'
      profile2 = Profile.create user_id: user1.id, description: "Some description", color: '#eeddaa'
      expect(user1.reload.default_profile.id).to eq profile1.id
    end

  end

  describe '#make_default' do

    it 'force user object to change its default_profile' do
      user1 = User.create(email:"qweasd@qwe.pl", password:'asdqwe123123')
      profile1 = Profile.create user_id: user1.id, description: "Some description", color: '#eeddaa'
      profile2 = Profile.create user_id: user1.id, description: "Some description", color: '#eeddaa'
      profile2.make_default
      expect(user1.reload.default_profile.id).to eq profile2.id
    end
  end

end
