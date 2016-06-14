class FetchDetail
  #validates :username ,presence: true

  def self.fetch_twitter_data(username)
    begin
      TweetClient.user_timeline(username).take(10)
    rescue => e
      return {:user => username, :error => "Not Found"}
    end
  end

  def self.fetch_github_data(username)
    begin
      user = Octokit.user username
    rescue => e
      return {:user => username, :repos => nil,:error => "Not Found"}
    end
    if user.present?
      repo_list = user.rels[:repos].get.data
    end
    return {:user => user, :repos => repo_list}
  end

  def self.fetch_rubygems_data(username)
    begin
      uri = URI.parse("https://rubygems.org/api/v1/owners/#{username}/gems.json")
      response = Net::HTTP.get_response(uri)
      if response.code == "200"
        return {:user => username, :gems => JSON.parse(response.body), :type => "RubyGems"}
      else
        return  {:user => username, :gems => [],:type=> "RubyGems",:error => "Not Found"}
      end
    rescue => e
      {:user => username, :gems => [],:type=> "RubyGems",:error => "Not Found"}
    end
  end
end
