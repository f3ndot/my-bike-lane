CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider           => 'Rackspace',
    :rackspace_username => ENV['RACKSPACE_USERNAME'],
    :rackspace_api_key  => ENV['RACKSPACE_KEY']
  }
  config.fog_directory = ENV['RACKSPACE_CONTAINER']
  config.asset_host = ENV['RACKSPACE_HOST']
end