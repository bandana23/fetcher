require "rails_helper"
RSpec.describe FetchDetailsController, :type => :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
    it "has sources" do
      get :index
      expect(assigns(:sources)).to eq(["GitHub", "Twitter", "RubyGems"])
    end
  end


  describe "POST 'fetch_user_data'" do
    it "should be successful" do
      post 'fetch_user_data', {"username"=>"santosh-1987", "source_ids"=>["GitHub"]}.to_json
      response.should be_success
    end
  end
end

