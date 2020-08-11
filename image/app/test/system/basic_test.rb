require "application_system_test_case"

class BasicTest < ApplicationSystemTestCase
  test "Browser visiting home" do
    visit "/"
    take_screenshot
    assert_selector "h1", text: "Yay! You’re on Rails!"
  end
end
