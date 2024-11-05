require "test_helper"

class PublishersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get publishers_index_url
    assert_response :success
  end
end
