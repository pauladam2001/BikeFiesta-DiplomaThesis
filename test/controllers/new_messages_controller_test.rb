require "test_helper"

class NewMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get new_messages_index_url
    assert_response :success
  end
end
