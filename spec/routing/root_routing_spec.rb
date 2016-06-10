require 'rails_helper'

describe 'Root of the site' do
  it "routs to pages\#home" do
    expect(get "/").to route_to(controller: "pages", action: "home")
  end
end
