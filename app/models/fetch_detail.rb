class FetchDetail

  def self.fetch_twitter_data(username)
    TweetClient.user_timeline(username).take(10)
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
    ""
  end
end