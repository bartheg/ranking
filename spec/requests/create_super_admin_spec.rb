require 'rails_helper'

RSpec.describe "Create Super Admin", type: :request do

  context "There is no registered users" do

    it "will not create user" do
      # there is no users
      expect(User.all).to be_empty

      # user signs un
      get "/install"
      expect(response).to render_template("pages/new_super_admin")
      post "/create_super_admin", user: {email: "testsuperadmin@test.com", password: "asdqwe123ASD"}

      # redirection to the root site
      expect(response).to redirect_to(root_path)
      follow_redirect!

      # user is in the base
      user = User.find_by(email: "testsuperadmin@test.com")
      expect(user).to_not be_nil

      # only one user is in the base
      expect(User.count).to eq 1

      # user is the super admin
      expect(user.has_role? :super_admin).to be true

      # # user goes to new report page
      # scenario_id = @scenario1.id
      # get "/scenarios/#{scenario_id}/reports/new"
      # expect(response).to render_template(:new)
      #
      # # user creates a new report
      # expect {
      #   post "/scenarios/#{scenario_id}/reports", report: {scenario_id: scenario_id, reporter_id: @profileA.id, reporters_faction_id: 3, confirmers_name: "pantherSS-88", confirmers_faction_id: 1, result_id: @victory.id}
      # }.to change{Report.count}.from(0).to(1)
      # expect(response).to redirect_to(reports_path)
      # expect(Report.last.status).to eq "unconfirmed"
      #
      # # user signs out
      # delete "/users/sign_out"
      # expect(response).to redirect_to(root_path)
      #
      # # another user signs in
      # get "/users/sign_in"
      # expect(response).to render_template(:new)
      # post "/users/sign_in", user: {email: @userB.email, password: "asd3we12ASD", remember_me: 1}
      # expect(response).to redirect_to(root_path)

    end

  end

  context "There is one registered user" do

    before(:context) do
      @userA = create :user_from_china
    end

    after(:context) do
      User.destroy_all
    end

  end


end
