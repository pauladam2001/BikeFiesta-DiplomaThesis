require "test_helper"

class CostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get costs_index_url
    assert_response :success
  end

  test "should get new" do
    get costs_new_url
    assert_response :success
  end

  test "should get create" do
    get costs_create_url
    assert_response :success
  end
end
