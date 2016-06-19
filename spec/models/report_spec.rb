require 'rails_helper'

RSpec.describe Report, type: :model do

  describe 'validations' do
    before do
      @user1 = User.create!(email:"qweasd@qwe.pl", password:'asdqwe123123')
      @user2 = User.create!(email:"1212qweasd@qwe.pl", password:'wasdqwe123123')
      @profile1 = Profile.create! user_id: @user1.id, name: "User1", description: "Some description", color: '#ffffff'
      @profile2 = Profile.create! user_id: @user2.id, name: "User2", description: "Some description", color: '#111111'
    end

    subject { Report.new(scenario_id: 1, reporter_id: @profile1.id, confirmer_id: @profile2.id,
      reporters_faction_id: 1, confirmers_faction_id: 2,
      result_id: 1, status: "unconfirmed") }

    it 'is valid when every field is OK' do
      expect(subject).to be_valid
    end

    it 'is invalid without scenario_id' do
      subject.scenario_id = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without reporter_id' do
      subject.reporter_id = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without confirmer_id' do
      subject.confirmer_id = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without reporters_faction_id' do
      subject.reporters_faction_id = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without confirmers_faction_id' do
      subject.confirmers_faction_id = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without result' do
      subject.result = nil
      expect(subject).to be_invalid
    end

    it 'is invalid when reporter and confirmer are the same user\'s profiles' do
      user1 = User.create!(email:"q555weasd@qwe.pl", password:'asdqwe123123')
      profile1 = Profile.create! user_id: user1.id, name: "Cheater1", description: "Some description", color: '#ffffff'
      profile2 = Profile.create! user_id: user1.id, name: "Cheater2", description: "Some description", color: '#111111'
      report = Report.new(scenario_id: 1, reporter_id: profile1.id, confirmer_id: profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: 1, status: "unconfirmed")
      expect(report).to be_invalid
    end

  end

  describe '#original_report' do

    before(:context) do
      @game = create :wesnoth
      @ladder = create :wesnoth_ladder, game: @game
      @scenario1 = create :freelands, ladder: @ladder
      @scenario2 = create :basilisk, ladder: @ladder
      @victory = create :victory, game: @game
      @defeat = create :defeat, game: @game
      @draw = create :draw, game: @game
      @user1 = create :user_from_china
      @user2 = create :user_from_poland
      @profile1 = create :sun_tzu, user: @user1
      @profile2 = create :panther, user: @user2
      @config = create :default_config, is_default: false, ladder: @ladder
    end

    after(:context) do
      DefaultLadderConfig.destroy_all
      Profile.destroy_all
      User.destroy_all
      PossibleResult.destroy_all
      Scenario.destroy_all
      Ladder.destroy_all
      Game.destroy_all
    end

    it 'returns nil if the scenarios are different' do
      different_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      different_scenario_report.created_at = 40.hours.ago
      different_scenario_report.save!
      subject = Report.new(scenario_id: @scenario2.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      expect(subject.original_report).to be_nil
    end

    it 'returns the previous report if all conditions are ok' do
      first_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")

      first_scenario_report.created_at = 48.hours.ago
      first_scenario_report.save!

      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      expect(subject.original_report).to eql first_scenario_report
    end

    it 'returns nil if the previous report is too old' do
      first_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      first_scenario_report.created_at = 50.hours.ago
      first_scenario_report.save!
      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      expect(subject.original_report).to be_nil
    end

    it 'returns nil if the profiles don\'t match' do
      first_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      first_scenario_report.created_at = 47.hours.ago
      first_scenario_report.save!
      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      expect(subject.original_report).to be_nil
    end

    it 'returns nil if the factions don\'t match' do
      first_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      first_scenario_report.created_at = 48.hours.ago
      first_scenario_report.save!
      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 1, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      expect(subject.original_report).to be_nil
    end

    it 'returns nil if the results don\'t match' do
      first_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      first_scenario_report.created_at = 48.hours.ago
      first_scenario_report.save!
      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @victory.id, status: "unconfirmed")

      expect(subject.original_report).to be_nil
    end

    it 'returns the older report if there are more than one ok reports' do
      first_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      first_scenario_report.created_at = 48.hours.ago
      first_scenario_report.save!

      second_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      second_scenario_report.created_at = 46.hours.ago
      second_scenario_report.save!

      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      expect(subject.original_report).to eql first_scenario_report
    end

    it 'cheks if confirmed is false' do
      first_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "confirmed")
      first_scenario_report.created_at = 48.hours.ago
      first_scenario_report.save!
      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      expect(subject.original_report).to be_nil
    end

  end

  describe '#previous' do

    before(:context) do
      @game = create :wesnoth
      @ladder = create :wesnoth_ladder, game: @game
      @scenario1 = create :freelands, ladder: @ladder
      @scenario2 = create :basilisk, ladder: @ladder
      @victory = create :victory, game: @game
      @defeat = create :defeat, game: @game
      @draw = create :draw, game: @game
      @user1 = create :user_from_china
      @user2 = create :user_from_poland
      @profile1 = create :sun_tzu, user: @user1
      @profile2 = create :panther, user: @user2
      @config = create :default_config, is_default: false, ladder: @ladder
    end

    after(:context) do
      DefaultLadderConfig.destroy_all
      Profile.destroy_all
      User.destroy_all
      PossibleResult.destroy_all
      Scenario.destroy_all
      Ladder.destroy_all
      Game.destroy_all
    end

    it 'returns only previous report for that player' do
      firts_report = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      subject = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      expect(subject.previous(@profile1)).to eql firts_report
    end

  end

end
