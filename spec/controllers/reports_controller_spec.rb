require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET index" do

    context "no parameters" do
      it "return success status" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "render the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "assigns @reports to empty relation" do
        get :index
        expect(assigns(:reports)).to match_array([])
      end
    end

    context "not existing profile parameter" do
      it "render no_profile_error page" do
        get :index, profile: 1
        expect(response).to render_template("no_profile_error")
      end

    end

    context "existing profile parameter" do

      before :context do
        @user1 = User.create!(email:"111@1qwe.pl", password:'asdqw123123')
        @user2 = User.create!(email:"222@2qwe.pl", password:'wasqwe123123')
        @user3 = User.create!(email:"333@3qwe.pl", password:'wsdqwe123123')
        @profile1 = Profile.create! user_id: @user1.id, name: "User1", description: "Some description", color: '#ffffff'
        @profile2 = Profile.create! user_id: @user2.id, name: "User2", description: "Some description", color: '#111111'
        @profile3 = Profile.create! user_id: @user3.id, name: "User3", description: "Some description", color: '#445111'
        @report12 = Report.create!(scenario_id: 1, reporter: @profile1, confirmer: @profile2, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: 1, status: "unconfirmed")
        @report23 = Report.create!(scenario_id: 1, reporter: @profile2, confirmer: @profile3, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: 1, status: "unconfirmed")
        @report31 = Report.create!(scenario_id: 1, reporter: @profile3, confirmer: @profile1, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: 1, status: "unconfirmed")
        @report21 = Report.create!(scenario_id: 1, reporter: @profile2, confirmer: @profile1, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: 1, status: "unconfirmed")
        @report32 = Report.create!(scenario_id: 1, reporter: @profile3, confirmer: @profile2, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: 1, status: "unconfirmed")
        @report13 = Report.create!(scenario_id: 1, reporter: @profile1, confirmer: @profile3, reporters_faction_id: 1, confirmers_faction_id: 2, result_id: 1, status: "unconfirmed")
      end

      after :context do
        Report.destroy_all
        Profile.destroy_all
        User.destroy_all
      end

      it "assigns @reports of that profile" do
        get :index, profile: @profile1
        expect(assigns(:reports)).to match_array([@report12, @report31, @report21, @report13,])
      end

    end


  end

end
