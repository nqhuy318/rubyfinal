require 'test_helper'

class TakeTestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get take_test_index_url
    assert_response :success
  end

end
