require 'rails_helper'
require 'spec_helper'

RSpec.describe FetchDetail, :type => :model do
      it "expects username for twiiter to fetch data" do
	   username = "bandanap"
	   data = TweetClient.user_timeline(username).take(10)
	   #user= FetchDetail.should(:fetch_twitter_data).with(username).and_raise(Exception)
	   allow(FetchDetail).to receive(:fetch_twitter_data).with(username)
	   # FetchDeta.to eq(bar)il.fetch_twitter_data(username).should== data
      end

      it "expects username for github to fetch data" do
	   username = "bandanap"
	   #user= FetchDetail.should(:fetch_twitter_data).with(username).and_raise(Exception)
	   allow(FetchDetail).to receive(:fetch_github_data).with(username)
      end
      it "expects username for rubygem to fetch data" do
	    username = "bandanap"
	   #user= FetchDetail.should(:fetch_twitter_data).with(username).and_raise(Exception)
	   allow(FetchDetail).to receive(:fetch_rubygems_data).with(username)
      end
      it "returns hash from  fetch detail for twitter" do
      	username = "bandanap"
        data = TweetClient.user_timeline(username).take(10)
        expect(FetchDetail.fetch_twitter_data(username)).to eq(data)
  	  end
      it "returns data from fetch detail for github" do
		username = "test"
		user = Octokit.user username
		repo_list = user.rels[:repos].get.data
		expect(FetchDetail.fetch_github_data(username)[:repos].count).to eq(repo_list.count)
	  end
  	  it "returns data from  fetch detail for rubygem" do
  	  	username = "test"
      	uri = URI.parse("https://rubygems.org/api/v1/owners/#{username}/gems.json")
        response = Net::HTTP.get_response(uri)
        data = {:user => username, :gems => JSON.parse(response.body), :type => "RubyGems"}
        if response.code == "200"
           expect(FetchDetail.fetch_rubygems_data(username)).to eq(data)
    	else
    	   expect(FetchDetail.fetch_rubygems_data(username)).to eq([])
    	end	
  	  end
end
