module ApplicationHelper

  def flagged_violations_count
    @flagged_count ||= Violation.where(:flagged => true).count
  end
  def spammed_violations_count
    @spammed_count ||= Violation.where(:spammed => true).count
  end

  def page_title
    return @title << " - MyBikeLane Toronto" if defined?(@title)
    "MyBikeLane Toronto - Get out of my bikelane!"
  end

  def avatar_url(user, size = 48)
    default_url = "#{root_url}/assets/default_avatar.png"
    if user.nil?
      default_url
    else
      gravatar_id = Digest::MD5.hexdigest user.email.downcase
      "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    end
  end

end
