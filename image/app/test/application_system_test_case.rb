# reducing db recreation
ActiveRecord::Base.maintain_test_schema = false

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# clossing rails_dev db and open rails_test db
ActiveRecord::Base.connection.close
ENV['RAILS_ENV'] = 'test'
Rails.env = "test"
ActiveRecord::Base.establish_connection (:test)

require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # for system test we are using 1 thread and 1 database rails_test
  parallelize(workers: 1)

  # reset test data in rails_test db
  fixtures :all
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1600, 1080], options: {
    url: "http://selenium:4444/wd/hub",
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless no-sandbox disable-gpu ignore-ssl-errors window-size=1600x1080] },
    )
  }
  def setup
    super

    # connecting to nginxtest and railstest containers
    Capybara.configure do |config|
      config.run_server = false
      config.app_host = 'http://nginxtest'
    end
  end
end