module FetchDetailsHelper
  def generate_html(v)
    if v.is_a?(Array)
      v.collect{ |data| "<li> #{data.text} </li>" }.join("\n").html_safe
    else
      if v[:error].present?
        "<p> Error: #{v[:error]}</p> ".html_safe
      else
        if v[:type]== "RubyGems"
          v[:gems].collect { |data| "<li> #{data["name"]} </li>" }.join("\n").html_safe
        else
          joining_date = "<p> Joining Date: #{v[:user][:created_at].to_s}</p> "
          repo_list = v[:repos].collect{ |data| "<li> #{data.full_name} </li>" }.join("\n")
          result = joining_date.concat(repo_list).html_safe
        end
      end
    end
  end
end