require 'rails_helper'

RSpec.describe "Adding reports", type: :request do

  before(:context) do
    create :default_config, default_ranking: 1400
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
    @userF = create :user_from_china, email: "germany@germany.ru", password: "germany23fdweiofj23"
    @profileA = create :sun_tzu, user: @userA
    @profileB = create :panther, user: @userB
    @profileC = create :sun_tzu, name: "Patton", user: @userC
    @profileD = create :sun_tzu, name: "Suvorov", user: @userD
    @profileE = create :sun_tzu, name: "Gandhi", user: @userE
    @profileF = create :sun_tzu, name: "Hitler", user: @userF
  end

  after(:context) do
    Profile.destroy_all
    User.destroy_all
    PossibleResult.destroy_all
    Scenario.destroy_all
    Ladder.destroy_all
    Game.destroy_all
    LadderConfig.destroy_all
  end


  it "creates a Report" do
    # user signs in
    get "/users/sign_in"
    expect(response).to render_template(:new)
    post "/users/sign_in", user: {email: @userA.email, password: "asdqwe123ASD", remember_me: 1}
    expect(response).to redirect_to(root_path)

    # user goes to new report page
    scenario_id = @scenario1.id
    get "/scenarios/#{scenario_id}/reports/new"
    expect(response).to render_template(:new)

    # user creates a new report
    expect {
      post "/scenarios/#{scenario_id}/reports", report: {scenario_id: scenario_id, reporter_id: @profileA.id, reporters_faction_id: 3, confirmers_name: "pantherSS-88", confirmers_faction_id: 1, result_id: @victory.id}
    }.to change{Report.count}.from(0).to(1)
    expect(response).to redirect_to(reports_path)
    expect(Report.last.status).to eq "unconfirmed"

    # user signs out
    delete "/users/sign_out"
    expect(response).to redirect_to(root_path)

    # another user signs in
    get "/users/sign_in"
    expect(response).to render_template(:new)
    post "/users/sign_in", user: {email: @userB.email, password: "asd3we12ASD", remember_me: 1}
    expect(response).to redirect_to(root_path)

    # user goes to new report page (different scenario)
    scenario_id = @scenario2.id
    get "/scenarios/#{scenario_id}/reports/new"
    expect(response).to render_template(:new)

    # user creates a another report
    expect {
      post "/scenarios/#{scenario_id}/reports", report: {scenario_id: scenario_id, reporter_id: @profileB.id, reporters_faction_id: 2, confirmers_name: "Suvorov", confirmers_faction_id: 3, result_id: @victory.id}
    }.to change{Report.count}.from(1).to(2)
    expect(response).to redirect_to(reports_path)
    expect(Report.last.status).to eq "unconfirmed"

    # user goes to new report page (same scenario as the first user)
    scenario_id = @scenario1.id
    get "/scenarios/#{scenario_id}/reports/new"
    expect(response).to render_template(:new)

    # user creates a report that should be confirmation instead of a new report
    expect {
      post "/scenarios/#{scenario_id}/reports", report: {scenario_id: scenario_id, reporter_id: @profileB.id, reporters_faction_id: 1, confirmers_name: "Sun_Tzu", confirmers_faction_id: 3, result_id: @defeat.id}
    }.to_not change{Report.count}
    expect(response).to redirect_to(reports_path)
    expect(Report.first.status).to eq "calculated"
    expect(Ranking.count).to eq 2
    expect(RankedPosition.count).to eq 2

  end

end
