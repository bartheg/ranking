require 'rails_helper'

RSpec.describe Report, type: :model do

  before(:context) do
    create :default_config
  end

  after(:context) do
    LadderConfig.destroy_all
  end

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


  describe '#handle_possible_confirmation' do

    before(:context) do
      create(:default_config)
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
    end

    after(:context) do
      LadderConfig.destroy_all
      Profile.destroy_all
      User.destroy_all
      PossibleResult.destroy_all
      Scenario.destroy_all
      Ladder.destroy_all
      Game.destroy_all
    end


    it 'does nothing when scenarios don\'t match' do
      subject = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      subject.created_at = 40.hours.ago
      subject.save!
      different_scenario_report = Report.new(scenario_id: @scenario2.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      different_scenario_report.handle_possible_confirmation
      subject.reload

      expect(subject.unconfirmed?).to be true
    end

    it 'sets was_just_confirmation? to false if it does nothing' do
      different_scenario_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      different_scenario_report.created_at = 40.hours.ago
      different_scenario_report.save!
      subject = Report.new(scenario_id: @scenario2.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      subject.handle_possible_confirmation

      expect(subject.was_just_confirmation?).to be false
    end

    it 'changes status of the report to confirmed when all conditions are ok' do
      subject = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      subject.created_at = 48.hours.ago
      subject.save!
      confirmation_report = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      confirmation_report.handle_possible_confirmation
      subject.reload

      expect(subject.confirmed?).to be true
    end

    it 'sets was_just_confirmation? to true when all conditions are ok' do
      report_to_confirmed = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      report_to_confirmed.created_at = 48.hours.ago
      report_to_confirmed.save!
      subject = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      subject.handle_possible_confirmation

      expect(subject.was_just_confirmation?).to be true
    end

    it 'does nothing when the previous report is too old' do
      subject = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      subject.created_at = 50.hours.ago
      subject.save!
      report_too_late = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      report_too_late.handle_possible_confirmation
      subject.reload

      expect(subject.unconfirmed?).to be true
    end

    it 'does nothing if the profiles don\'t match' do
      subject = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      subject.created_at = 47.hours.ago
      subject.save!
      report_with_different_profiles = Report.new(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      report_with_different_profiles.handle_possible_confirmation
      subject.reload

      expect(subject.unconfirmed?).to be true
    end

    it 'does nothing if the factions don\'t match' do
      subject = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      subject.created_at = 47.hours.ago
      subject.save!
      report_with_different_factions = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @defeat.id, status: "unconfirmed")

      report_with_different_factions.handle_possible_confirmation
      subject.reload

      expect(subject.unconfirmed?).to be true
    end

    it 'does nothing when the results don\'t match' do
      subject = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      subject.created_at = 47.hours.ago
      subject.save!
      report_with_different_result = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @draw.id, status: "unconfirmed")

      report_with_different_result.handle_possible_confirmation
      subject.reload

      expect(subject.unconfirmed?).to be true
    end

    it 'confirms the older report if there are more than one ok reports' do
      first_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      first_report.created_at = 48.hours.ago
      first_report.save!

      second_report = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "unconfirmed")
      second_report.created_at = 46.hours.ago
      second_report.save!

      confirmation_report = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      confirmation_report.handle_possible_confirmation
      first_report.reload
      second_report.reload

      expect((first_report.confirmed? and second_report.unconfirmed?)).to be true
    end

    it 'doesnt update confirmed reports' do
      subject = Report.create!(scenario_id: @scenario1.id, reporter_id: @profile1.id, confirmer_id: @profile2.id, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: @victory.id, status: "confirmed")
      subject.created_at = 48.hours.ago
      subject.save!
      confirmation_report = Report.new(scenario_id: @scenario1.id, reporter_id: @profile2.id, confirmer_id: @profile1.id, reporters_faction_id: 2, confirmers_faction_id: 1, result_id: @defeat.id, status: "unconfirmed")

      subject.reload
      update_time_before = subject.updated_at
      confirmation_report.handle_possible_confirmation
      subject.reload
      update_time_after = subject.updated_at

      expect(update_time_before).to eq update_time_after
    end

  end


  describe '#previous' do

    before(:context) do
      create(:default_config)
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
    end

    after(:context) do
      LadderConfig.destroy_all
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

    it 'returns only previous report for that player even if the player is confirmer' do
      firts_report = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      subject = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      expect(subject.previous(@profile2)).to eql firts_report
    end

    it 'returns only previous report for that player and ignores reports for another scenarios' do
      another_scenario_report = Report.create!(scenario: @scenario2, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      previous_report = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      yet_another_another_scenario_report = Report.create!(scenario: @scenario2,
        reporter: @profile1, confirmer: @profile2, reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      subject = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      expect(subject.previous(@profile1)).to eql previous_report
    end

    it 'returns nil if no previous reports' do
      subject = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      next_report = Report.create!(scenario: @scenario1, reporter: @profile1, confirmer: @profile2,
        reporters_faction_id: 1, confirmers_faction_id: 2,
        result: @victory, status: "unconfirmed")
      expect(subject.previous(@profile1)).to be_nil
    end

  end

  describe 'by_profile' do

    before(:context) do
      create(:default_config)
      @game = create :wesnoth
      @ladder = create :wesnoth_ladder, game: @game
      @blitz_ladder = create :wesnoth_blitz_ladder, game: @game
      @scenario1 = create :freelands, ladder: @ladder
      @scenario2 = create :basilisk, ladder: @ladder
      @scenario1b = create :freelands, ladder: @blitz_ladder
      @scenario2b = create :basilisk, ladder: @blitz_ladder
      @victory = create :victory, game: @game
      @defeat = create :defeat, game: @game
      @draw = create :draw, game: @game
      @userA = create :user_from_china
      @userB = create :user_from_poland
      @userC = create :user_from_china, email: "usa@usa.us", password: "usa23edwjeio23"
      @userD = create :user_from_china, email: "russia@russia.ru", password: "russia23fdweiofj23"
      @userE = create :user_from_china, email: "indoa@india.id", password: "india23edwjeio23"
      @profileA = create :sun_tzu, user: @userA
      @profileB = create :panther, user: @userB
      @profileC = create :sun_tzu, name: "Patton", user: @userC
      @profileD = create :sun_tzu, name: "Suvorov", user: @userD
      @profileE = create :sun_tzu, name: "Gandhi", user: @userE
    end

    after(:context) do
      LadderConfig.destroy_all
      Profile.destroy_all
      User.destroy_all
      PossibleResult.destroy_all
      Scenario.destroy_all
      Ladder.destroy_all
      Game.destroy_all
    end

    before(:example) do
      @reportAB =  Report.create!(scenario: @scenario1, reporter: @profileA, confirmer: @profileB, reporters_faction_id: 1, confirmers_faction_id: 2, result: @victory, status: :calculated)
      @reportCD = Report.create!(scenario: @scenario2b, reporter: @profileC, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @defeat, status: :confirmed)
      @reportAD =  Report.create!(scenario_id: @scenario1.id, reporter: @profileA, confirmer: @profileD, reporters_faction_id: 1, confirmers_faction_id: 2, result: @draw, status: :unconfirmed)
    end

    it 'returns empty collection if no reports by given profile' do
      expect(Report.by_profile(@profileE)).to be_empty
    end

    it 'returns collection of 2 reports for profileD' do
      expect(Report.by_profile(@profileD)).to include(@reportAD, @reportCD)
    end


  end
end
