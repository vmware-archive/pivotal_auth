require 'capybara/rspec'

Capybara.configure do |config|
  config.javascript_driver = :selenium
  config.asset_host = 'http://localhost:3000'
  config.server_port = 8002
end
