require "test_helper"

class ComponentGroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get component_groups_index_url
    assert_response :success
  end
end
