require 'rails_helper'

RSpec.describe Profile, type: :model do

  describe 'validations' do
    subject { Profile.new user_id: 1, name: "Sun-Zi", description: "Some description", color: '#eeddaa'}

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    it 'is invalid without user_id' do
      subject.user_id = nil
      expect(subject).to be_invalid
    end



    it 'is invalid without name' do
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'is valid when name has only basic letters, numbers "-", "." and "_"' do
      subject.name ='ABJxyz0189-._'
      expect(subject).to be_valid
    end

    it 'is invalid when name has url unfriendly characters' do
      subject.name =';s[=_ #]23wesdc'
      expect(subject).to be_invalid
    end

    it 'is invalid when name has more than 24 characters' do
      subject.name ='a' * 25
      expect(subject).to be_invalid
    end

    it 'is invalid when name has less than 3 characters' do
      subject.name ='a' * 2
      expect(subject).to be_invalid
    end

    it 'is invalid when name has not any letter' do
      subject.name ='12_'
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
      profile = Profile.create user_id: user.id, name: "KkkK", description: "Some description", color: '#eeddaa'

      expect(user.reload.default_profile.id).to eq profile.id
    end

    it 'doesnt change default_profile when there is one' do
      user1 = User.create(email:"qweasd@qwe.pl", password:'asdqwe123123')
      profile1 = Profile.create user_id: user1.id, name: "ErkK", description: "Some description", color: '#eeddaa'
      profile2 = Profile.create user_id: user1.id, name: "KEkK", description: "Some description", color: '#eeddaa'
      expect(user1.reload.default_profile.id).to eq profile1.id
    end

  end

  describe '#make_default' do

    it 'force user object to change its default_profile' do
      user1 = User.create(email:"qweasd@qwe.pl", password:'asdqwe123123')
      profile1 = Profile.create user_id: user1.id, name: "KEk4rfK", description: "Some description", color: '#eeddaa'
      profile2 = Profile.create user_id: user1.id, name: "K44K", description: "Some description", color: '#eeddaa'
      profile2.make_default
      expect(user1.reload.default_profile.id).to eq profile2.id
    end
  end

  describe '.by_user' do
    let! (:u1) { User.create email: 'qwe@qwe.qw', password: '123qweasd', profile_id: 1 }
    let! (:p1) { Profile.create user_id: u1.id, name: "KEkasdweafwefsdK", description: "Description", color: '#edddaa' }
    let! (:p2) { Profile.create user_id: u1.id, name: "KEkasdweafwdK", description: "Description 2", color: '#cdddaa' }
    let! (:u2) { User.create email: 'qsse@qwe.qw', password: '1s3qweasd', profile_id: 3 }
    let! (:p3) { Profile.create user_id: u2.id, name: "KE2323cvfd--kK", description: "Description 3", color: '#ed4daa' }
    let! (:p4) { Profile.create user_id: u2.id, name: "KE23ff23cvfd--kK", description: "Description 4", color: '#cdd51a' }
    let! (:u3) { User.create email: 'qffse@qwe.qw', password: '1s3sdeeasd', profile_id: nil }

    it 'returns profiles of the user' do
      expect(Profile.by_user u1).to match_array [p2, p1]
    end

    context 'no current_user' do
      let (:current_user) { nil }
      it 'returns false' do
        expect(Profile.by_user current_user).to be false
      end
    end

    context 'current user has not any profiles' do
      it 'returns empty relation' do
        current_user = u3
        profiles = Profile.by_user current_user
        expect(profiles).to be_empty
      end
    end

  end



end
