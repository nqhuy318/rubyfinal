require 'test_helper'

class SearchWorksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_works_index_url
    assert_response :success
  end

end
