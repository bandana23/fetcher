require "spec_helper"

describe "routes for FetchDetails" , :type => :routing  do
  it "routes to fetch user data" do
    expect(:post=>"/fetch_details/fetch_user_data").to route_to("fetch_details#fetch_user_data")
  end
end

describe 'Routes', :type => :routing do
	it "should check the desired routes " do
		expect(:get => "fetch_details").to route_to(:controller => "fetch_details",:action => "index")
	end
end