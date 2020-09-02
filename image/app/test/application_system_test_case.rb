require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1600, 1080], options: {
    url: "http://selenium:4444/wd/hub",
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless window-size=1600x1080] },
    )
  }
  def setup
    super
    Capybara.configure do |config|
      config.run_server = false
      config.app_host = 'http://nginxtest'
    end
  end
end