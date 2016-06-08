require 'rails_helper'

RSpec.describe PossibleResultsController, type: :controller do

  describe "GET #edit" do
    xit "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
