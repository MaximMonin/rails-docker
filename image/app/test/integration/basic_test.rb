require 'test_helper'

class BasicTest < ActionDispatch::IntegrationTest
  test "visit home" do
    get "/"
    assert_equal 200, status
    assert_select 'h1', "Yay! You’re on Rails!"
  end
end
