require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["SELENIUM_REMOTE_URL"]
    Capybara.server_host = ENV.fetch("CAPYBARA_SERVER_HOST", "0.0.0.0")
    Capybara.server_port = 3001
    Capybara.app_host = "http://web:3001"


    driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ], options: {
      browser: :remote,
      url: ENV["SELENIUM_REMOTE_URL"]
    }
  else
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  end
end
