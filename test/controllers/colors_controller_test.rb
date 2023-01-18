require "test_helper"

class ColorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get colors_index_url
    assert_response :success
  end
end
