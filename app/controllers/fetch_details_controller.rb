class FetchDetailsController < ApplicationController

  def index
   @sources = ["GitHub","Twitter","RubyGems"]
  end
  # POST / Fetches Data frpm Social Plugins
  def fetch_user_data
    @username = params[:username]
    @configured_sources = params[:source_ids] || []
    @result_set = Hash.new
    @configured_sources.each do |source|
      feed_result = fetch_feed(source,@username)
      @result_set[source] = feed_result
    end
   
  end

  def download_pdf
    send_file(
      "#{Rails.root}/public/fetch_details.pdf",
      filename: "fetch_user_data.pdf",
      type: "application/pdf"
    )
  end

  private

  def fetch_feed(source,username)
    case source
      when "Twitter"
        FetchDetail.fetch_twitter_data(username)
      when "GitHub"
        FetchDetail.fetch_github_data(username)
      when "RubyGems"
        FetchDetail.fetch_rubygems_data(username)
      else
        ""
    end
  end
end
