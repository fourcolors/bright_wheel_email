require 'test_helper'

class EmailControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    post email_url
    assert_response :success
  end
end
