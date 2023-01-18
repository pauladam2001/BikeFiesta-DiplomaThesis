require "test_helper"

class BrandnamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get brandnames_index_url
    assert_response :success
  end
end
