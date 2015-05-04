if Rails.env == 'development'
  MyBikeLane::Application.config.rakismet.key = ENV['AKISMET_KEY'] || "deadbeefdead"
  MyBikeLane::Application.config.rakismet.url = ENV['AKISMET_DOMAIN'] || "http://localhost"
  MyBikeLane::Application.config.rakismet.test = true
else
  MyBikeLane::Application.config.rakismet.key = ENV['AKISMET_KEY']
  MyBikeLane::Application.config.rakismet.url = ENV['AKISMET_DOMAIN']
end
