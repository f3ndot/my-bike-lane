MyBikeLane::Application.config.rakismet.key = ENV['AKISMET_KEY']
MyBikeLane::Application.config.rakismet.url = ENV['AKISMET_DOMAIN']

if Rails.env == 'development'
  MyBikeLane::Application.config.rakismet.test = true
end
